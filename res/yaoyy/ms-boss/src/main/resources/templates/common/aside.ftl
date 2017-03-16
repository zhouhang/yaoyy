    <!-- 侧栏菜单 -->
    <div class="sidebar">
        <dl>
            <dt>
                <a href="index"><i class="fa fa-dashboard"></i>控制面板</a>
            </dt>
        </dl>
        <@shiro.hasPermission name="specialad:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-star"></i>
                    <span>专场广告</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
            <@shiro.hasPermission name="special:list">
                <a href="special/list" id="navItem1-1"><i class="fa fa-circle-o"></i>专场列表</a>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="ad:list">
                <a href="ad/list" id="navItem1-2"><i class="fa fa-circle-o"></i>广告列表</a>
            </@shiro.hasPermission>
            </dd>
        </dl>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="cms:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-file-text"></i>
                    <span>CMS管理</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
                <@shiro.hasPermission name="cms:list">
                <a href="cms/list" id="navItem2-1"><i class="fa fa-circle-o"></i>CMS列表</a>
                </@shiro.hasPermission>
            </dd>
        </dl>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="user:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-user"></i>
                    <span>用户管理</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
                <@shiro.hasPermission name="user:list">
                <a href="/user/list" id="navItem3-1"><i class="fa fa-circle-o"></i>用户列表</a>
                </@shiro.hasPermission>
            </dd>
        </dl>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="sample:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-truck"></i>
                    <span>寄样服务</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
                <@shiro.hasPermission name="sample:list">
                    <a href="/sample/list" id="navItem4-1"><i class="fa fa-circle-o"></i>寄样列表</a>
                </@shiro.hasPermission>
            </dd>
        </dl>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="pick:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-shopping-bag"></i>
                    <span>订单管理</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
                <@shiro.hasPermission name="pick:list">
                <a href="/pick/list" id="navItem5-1"><i class="fa fa-circle-o"></i>订单列表</a>
                </@shiro.hasPermission>
            </dd>
        </dl>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="commodity:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-cart-plus"></i>
                    <span>商品管理</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
                <@shiro.hasPermission name="category:list">
                    <a href="/category/list" id="navItem6-1"><i class="fa fa-circle-o"></i>品种列表</a>
                </@shiro.hasPermission>
                <@shiro.hasPermission name="commodity:list">
                    <a href="/commodity/list" id="navItem6-2"><i class="fa fa-circle-o"></i>商品列表</a>
                </@shiro.hasPermission>
            </dd>
        </dl>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="memberole:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-list"></i>
                    <span>账号权限</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
                <@shiro.hasPermission name="member:list">
                    <a href="/member/index" id="navItem7-1"><i class="fa fa-circle-o"></i>管理员列表</a>
                </@shiro.hasPermission>
                <@shiro.hasPermission name="role:list">
                    <a href="/role/index" id="navItem7-2"><i class="fa fa-circle-o"></i>角色列表</a>
                </@shiro.hasPermission>
            </dd>
        </dl>
        </@shiro.hasPermission>
       <@shiro.hasPermission name="supplier:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-users"></i>
                    <span>供应商管理</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
                <@shiro.hasPermission name="supplier:unsign">
                <a href="/supplier/list" id="navItem8-1"><i class="fa fa-circle-o"></i>未签约供应商</a>
                </@shiro.hasPermission>
                <@shiro.hasPermission name="supplier:sign">
                <a href="/supplier/signlist" id="navItem8-2"><i class="fa fa-circle-o"></i>签约供应商</a>
                </@shiro.hasPermission>
                <#--<a href="/supplier/stock" id="navItem8-3"><i class="fa fa-circle-o"></i>寄卖库存管理</a>-->
                <#--<a href="/supplier/commodity" id="navItem8-4"><i class="fa fa-circle-o"></i>寄卖商品列表</a>-->
                <#--<a href="/supplier/order" id="navItem8-5"><i class="fa fa-circle-o"></i>寄卖订单列表</a>-->
            </dd>
        </dl>
        </@shiro.hasPermission>


    <@shiro.hasPermission name="pay:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-money"></i>
                    <span>账单流水管理</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
                <@shiro.hasPermission name="payRecord:list">
                    <a href="/payRecord/list" id="navItem9-1"><i class="fa fa-circle-o"></i>交易流水列表</a>
                </@shiro.hasPermission>
                <@shiro.hasPermission name="bill:list">
                    <a href="/bill/list" id="navItem9-2"><i class="fa fa-circle-o"></i>账单列表</a>
                </@shiro.hasPermission>
            </dd>
        </dl>
    </@shiro.hasPermission>
    <@shiro.hasPermission name="setting:all">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-cog"></i>
                    <span>系统设置</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
                <a href="/setting" id="navItem10-1"><i class="fa fa-circle-o"></i>系统设置</a>
            </dd>
        </dl>
    </@shiro.hasPermission>
       <@shiro.hasPermission name="quotation:index">
        <dl>
            <dt>
                <a href="javascript:;">
                    <i class="fa fa-flag"></i>
                    <span>资讯管理</span>
                    <i class="fa fa-angle-down arrow"></i>
                </a>
            </dt>
            <dd>
               <@shiro.hasPermission name="quotation:list">
                <a href="/quotation/list" id="navItem11-1"><i class="fa fa-circle-o"></i>报价单列表</a>
               </@shiro.hasPermission>
                <a href="/announcement/list" id="navItem11-2"><i class="fa fa-circle-o"></i>网站公告</a>
            </dd>
        </dl>
       </@shiro.hasPermission>

    </div>