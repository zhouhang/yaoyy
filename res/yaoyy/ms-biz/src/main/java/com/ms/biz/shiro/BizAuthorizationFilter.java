package com.ms.biz.shiro;

import com.ms.biz.controller.WechatController;
import com.ms.biz.properties.BizSystemProperties;
import com.ms.dao.enums.UserTypeEnum;
import com.ms.dao.model.User;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.utils.HttpUtil;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.mp.api.WxMpService;
import org.apache.log4j.Logger;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.StringUtils;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 用于验证身份信息
 *
 */
public class BizAuthorizationFilter extends AuthorizationFilter {


	@Autowired
	private WxMpService wxService;
	@Autowired
	private BizSystemProperties systemProperties;

	private Pattern pattern = Pattern.compile("supplier",Pattern.CASE_INSENSITIVE);

	@Override
	public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue)
			throws IOException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		String ua = httpRequest.getHeader("user-agent").toLowerCase();
		Subject subject = getSubject(request, response);

		Session httpSession = subject.getSession();
		User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());

		String uri = httpRequest.getRequestURI();
		Matcher matcher = pattern.matcher(uri);
		if (matcher.find()) {
			// 供应商用户登入
			if (user == null || user.getType() == UserTypeEnum.purchase.getType()) {
				saveRequest(request);
				WebUtils.issueRedirect(request, response, "/user/supplier/login");
				return false;
			}

		} else {
			// 先判断是否需要重新登录
			if (subject.getPrincipal() == null) {
				saveRequest(request);
				String source = request.getParameter("source");
				if ("WECHAT".equals(source) || ua.indexOf("micromessenger") > 0) {
					String relUrl = HttpUtil.getRelUrl(httpRequest);
					String wechatLoginUrl = systemProperties.getBaseUrl() + "/wechat/login?call=" + relUrl;
					String OAUTH_URL = wxService.oauth2buildAuthorizationUrl(wechatLoginUrl, WxConsts.OAUTH2_SCOPE_USER_INFO, "weixin_state");
//				httpResponse.sendRedirect(OAUTH_URL);
					WebUtils.issueRedirect(request, response, OAUTH_URL);
				} else {
					WebUtils.issueRedirect(request, response, getLoginUrl());
				}
				return false;
			}
		}


		return true;
	}


	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
//		Subject subject = getSubject(request, response);
//		// If the subject isn't identified, redirect to login URL
//		if (subject.getPrincipal() == null) {
//			saveRequest(request);
//		}
		return false;
	}



}
