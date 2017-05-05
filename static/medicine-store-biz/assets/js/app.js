// dropload
!function(o){"use strict";function t(o){o.touches||(o.touches=o.originalEvent.touches)}function n(o,t){t._startY=o.touches[0].pageY,t.touchScrollTop=t.$scrollArea.scrollTop()}function s(t,n){n._curY=t.touches[0].pageY,n._moveY=n._curY-n._startY,n._moveY>0?n.direction="down":n._moveY<0&&(n.direction="up");var s=Math.abs(n._moveY);""!=n.opts.loadUpFn&&n.touchScrollTop<=0&&"down"==n.direction&&!n.isLockUp&&(t.preventDefault(),n.$domUp=o("."+n.opts.domUp.domClass),n.upInsertDOM||(n.$element.prepend('<div class="'+n.opts.domUp.domClass+'"></div>'),n.upInsertDOM=!0),a(n.$domUp,0),s<=n.opts.distance?(n._offsetY=s,n.$domUp.html(n.opts.domUp.domRefresh)):s>n.opts.distance&&s<=2*n.opts.distance?(n._offsetY=n.opts.distance+.5*(s-n.opts.distance),n.$domUp.html(n.opts.domUp.domUpdate)):n._offsetY=n.opts.distance+.5*n.opts.distance+.2*(s-2*n.opts.distance),n.$domUp.css({height:n._offsetY}))}function e(t){var n=Math.abs(t._moveY);""!=t.opts.loadUpFn&&t.touchScrollTop<=0&&"down"==t.direction&&!t.isLockUp&&(a(t.$domUp,300),n>t.opts.distance?(t.$domUp.css({height:t.$domUp.children().height()}),t.$domUp.html(t.opts.domUp.domLoad),t.loading=!0,t.opts.loadUpFn(t)):t.$domUp.css({height:"0"}).on("webkitTransitionEnd mozTransitionEnd transitionend",function(){t.upInsertDOM=!1,o(this).remove()}),t._moveY=0)}function i(o){""!=o.opts.loadDownFn&&o.opts.autoLoad&&o._scrollContentHeight-o._threshold<=o._scrollWindowHeight&&l(o)}function d(o){o._scrollContentHeight=o.opts.scrollArea==r?m.height():o.$element[0].scrollHeight}function l(o){o.direction="up",o.$domDown.html(o.opts.domDown.domLoad),o.loading=!0,o.opts.loadDownFn(o)}function a(o,t){o.css({"-webkit-transition":"all "+t+"ms",transition:"all "+t+"ms"})}var r=window,c=document,p=o(r),m=o(c);o.fn.dropload=function(o){return new h(this,o)};var h=function(o,t){var n=this;n.$element=o,n.upInsertDOM=!1,n.loading=!1,n.isLockUp=!1,n.isLockDown=!1,n.isData=!0,n._scrollTop=0,n._threshold=0,n.init(t)};h.prototype.init=function(d){var a=this;a.opts=o.extend(!0,{},{scrollArea:a.$element,domUp:{domClass:"dropload-up",domRefresh:'<div class="dropload-refresh">↓下拉刷新</div>',domUpdate:'<div class="dropload-update">↑释放更新</div>',domLoad:'<div class="dropload-load"><span class="loading"></span>加载中</div>'},domDown:{domClass:"dropload-down",domRefresh:'<div class="dropload-refresh">↑上拉加载更多</div>',domLoad:'<div class="dropload-load"><span class="loading"></span>加载中...</div>',domNoData:'<div class="dropload-noData">没有更多了 :)</div>'},autoLoad:!0,distance:50,threshold:50,loadUpFn:"",loadDownFn:""},d),""!=a.opts.loadDownFn&&(a.$element.append('<div class="'+a.opts.domDown.domClass+'">'+a.opts.domDown.domRefresh+"</div>"),a.$domDown=o("."+a.opts.domDown.domClass)),a._threshold=a.$domDown&&""===a.opts.threshold?Math.floor(1*a.$domDown.height()/3):a.opts.threshold,a.opts.scrollArea==r?(a.$scrollArea=p,a._scrollContentHeight=m.height(),a._scrollWindowHeight=c.documentElement.clientHeight):(a.$scrollArea=a.opts.scrollArea,a._scrollContentHeight=a.$element[0].scrollHeight,a._scrollWindowHeight=a.$element.height()),i(a),p.on("resize",function(){clearTimeout(a.timer),a.timer=setTimeout(function(){a._scrollWindowHeight=a.opts.scrollArea==r?r.innerHeight:a.$element.height(),i(a)},150)}),a.$element.on("touchstart",function(o){a.loading||(t(o),n(o,a))}),a.$element.on("touchmove",function(o){a.loading||(t(o,a),s(o,a))}),a.$element.on("touchend",function(){a.loading||e(a)}),a.$scrollArea.on("scroll",function(){a._scrollTop=a.$scrollArea.scrollTop(),""!=a.opts.loadDownFn&&!a.loading&&!a.isLockDown&&a._scrollContentHeight-a._threshold<=a._scrollWindowHeight+a._scrollTop&&l(a)})},h.prototype.lock=function(o){var t=this;void 0===o?"up"==t.direction?t.isLockDown=!0:"down"==t.direction?t.isLockUp=!0:(t.isLockUp=!0,t.isLockDown=!0):"up"==o?t.isLockUp=!0:"down"==o&&(t.isLockDown=!0,t.direction="up")},h.prototype.unlock=function(){var o=this;o.isLockUp=!1,o.isLockDown=!1,o.direction="up"},h.prototype.noData=function(o){var t=this;void 0===o||1==o?t.isData=!1:0==o&&(t.isData=!0)},h.prototype.resetload=function(){var t=this;"down"==t.direction&&t.upInsertDOM?t.$domUp.css({height:"0"}).on("webkitTransitionEnd mozTransitionEnd transitionend",function(){t.loading=!1,t.upInsertDOM=!1,o(this).remove(),d(t)}):"up"==t.direction&&(t.loading=!1,t.isData?(t.$domDown.html(t.opts.domDown.domRefresh),d(t),i(t)):t.$domDown.html(t.opts.domDown.domNoData))}}(window.Zepto||window.jQuery);

// swipeSlide
!function(a,b){"use strict";function h(a,b,c){b.css({"-webkit-transition":"all "+c+"s "+a.opts.transitionType,transition:"all "+c+"s "+a.opts.transitionType})}function i(a,b,c){var d=a.opts.axisX?c+"px,0,0":"0,"+c+"px,0";b.css({"-webkit-transform":"translate3d("+d+")",transform:"translate3d("+d+")"})}function j(a,c){var d=a.opts.ul.children(),e=d.eq(c).find("[data-src]");e&&e.each(function(){var c=b(this);c.is("img")?(c.attr("src",c.data("src")),c.removeAttr("data-src")):(c.css({"background-image":"url("+c.data("src")+")"}),c.removeAttr("data-src"))})}function k(a){e.touch&&!a.touches&&(a.touches=a.originalEvent.touches)}function l(a,b){b.isScrolling=void 0,b._moveDistance=b._moveDistanceIE=0,b._startX=e.touch?a.touches[0].pageX:a.pageX||a.clientX,b._startY=e.touch?a.touches[0].pageY:a.pageY||a.clientY}function m(a,b){b.opts.autoSwipe&&p(b),b.allowSlideClick=!1,b._curX=e.touch?a.touches[0].pageX:a.pageX||a.clientX,b._curY=e.touch?a.touches[0].pageY:a.pageY||a.clientY,b._moveX=b._curX-b._startX,b._moveY=b._curY-b._startY,"undefined"==typeof b.isScrolling&&(b.isScrolling=b.opts.axisX?!!(Math.abs(b._moveX)>=Math.abs(b._moveY)):!!(Math.abs(b._moveY)>=Math.abs(b._moveX))),b.isScrolling&&(a.preventDefault?a.preventDefault():a.returnValue=!1,h(b,b.opts.ul,0),b._moveDistance=b._moveDistanceIE=b.opts.axisX?b._moveX:b._moveY),b.opts.continuousScroll||(0==b._index&&b._moveDistance>0||b._index+1>=b._liLength&&b._moveDistance<0)&&(b._moveDistance=0),i(b,b.opts.ul,-(b._slideDistance*b._index-b._moveDistance))}function n(a){a.isScrolling||o(a),(c.ie10||c.ie11)&&(Math.abs(a._moveDistanceIE)<5&&(a.allowSlideClick=!0),setTimeout(function(){a.allowSlideClick=!0},100)),Math.abs(a._moveDistance)<=a._distance?q(a,"",".3"):a._moveDistance>a._distance?q(a,"prev",".3"):Math.abs(a._moveDistance)>a._distance&&q(a,"next",".3"),a._moveDistance=a._moveDistanceIE=0}function o(a){a.opts.autoSwipe&&(p(a),a.autoSlide=setInterval(function(){q(a,"next",".3")},a.opts.speed))}function p(a){clearInterval(a.autoSlide)}function q(a,b,c){"number"==typeof b?(a._index=b,a.opts.lazyLoad&&(a.opts.continuousScroll?(j(a,a._index),j(a,a._index+1),j(a,a._index+2)):(j(a,a._index-1),j(a,a._index),j(a,a._index+1)))):"next"==b?(a._index++,a.opts.lazyLoad&&(a.opts.continuousScroll?(j(a,a._index+1),a._index+1==a._liLength?j(a,1):a._index==a._liLength&&j(a,0)):j(a,a._index+1))):"prev"==b&&(a._index--,a.opts.lazyLoad&&(a.opts.continuousScroll?(j(a,a._index),0==a._index?j(a,a._liLength):a._index<0&&j(a,a._liLength-1)):j(a,a._index-1))),a.opts.continuousScroll?a._index>=a._liLength?(r(a,c),a._index=0,setTimeout(function(){r(a,0)},300)):a._index<0?(r(a,c),a._index=a._liLength-1,setTimeout(function(){r(a,0)},300)):r(a,c):(a._index>=a._liLength?a._index=0:a._index<0&&(a._index=a._liLength-1),r(a,c)),""!==arguments[1]&&a.opts.callback(a._index,a._liLength,a.$el)}function r(a,b){h(a,a.opts.ul,b),i(a,a.opts.ul,-a._index*a._slideDistance)}var f,g,c={ie10:a.navigator.msPointerEnabled,ie11:a.navigator.pointerEnabled},d=["touchstart","touchmove","touchend"],e={touch:a.Modernizr&&Modernizr.touch===!0||function(){return!!("ontouchstart"in a||a.DocumentTouch&&document instanceof DocumentTouch)}()};c.ie10&&(d=["MSPointerDown","MSPointerMove","MSPointerUp"]),c.ie11&&(d=["pointerdown","pointermove","pointerup"]),f={touchStart:d[0],touchMove:d[1],touchEnd:d[2]},b.fn.swipeSlide=function(a){var b=[];return this.each(function(c,d){b.push(new g(d,a))}),b},g=function(a,c){var d=this;d.$el=b(a),d._distance=50,d.allowSlideClick=!0,d.init(c)},g.prototype.init=function(d){function p(){var c,a=e.opts.ul.children();e._slideDistance=e.opts.axisX?e.opts.ul.width():e.opts.ul.height(),h(e,e.opts.ul,0),i(e,e.opts.ul,-e._slideDistance*e._index),h(e,a,0),c=e.opts.continuousScroll?-1:0,a.each(function(a){i(e,b(this),e._slideDistance*(a+c))})}var g,e=this;return e.opts=b.extend({},{ul:e.$el.children("ul"),li:e.$el.children().children("li"),index:0,continuousScroll:!0,autoSwipe:!1,speed:4e3,axisX:!0,transitionType:"ease",lazyLoad:!1,firstCallback:function(){},callback:function(){}},d),e._index=e.opts.index,e._liLength=e.opts.li.length,e.isScrolling,e.opts.firstCallback(e._index,e._liLength,e.$el),e._liLength<=1?(e.opts.lazyLoad&&j(e,0),!1):(e.opts.continuousScroll&&e.opts.ul.prepend(e.opts.li.last().clone()).append(e.opts.li.first().clone()),e.opts.lazyLoad&&(j(e,e._index),e.opts.continuousScroll?(j(e,e._index+1),j(e,e._index+2),0==e._index?j(e,e._liLength):e._index+1==e._liLength&&j(e,1)):0==e._index?j(e,e._index+1):e._index+1==e._liLength?j(e,e._index-1):(j(e,e._index+1),j(e,e._index-1))),p(),(c.ie10||c.ie11)&&(g="",g=e.opts.axisX?"pan-y":"none",e.$el.css({"-ms-touch-action":g,"touch-action":g}),e.$el.on("click",function(){return e.allowSlideClick})),o(e),e.$el.on(f.touchStart,function(a){k(a),l(a,e)}),e.$el.on(f.touchMove,function(a){k(a),m(a,e)}),e.$el.on(f.touchEnd,function(){n(e)}),e.opts.ul.on("webkitTransitionEnd MSTransitionEnd transitionend",function(){o(e)}),b(a).on("onorientationchange"in a?"orientationchange":"resize",function(){clearTimeout(e.timer),e.timer=setTimeout(p,150)}),void 0)},g.prototype.goTo=function(a){var b=this;q(b,a,".3")}}(window,window.Zepto||window.jQuery);

/*! fly - v1.0.0 - 2015-03-23
* https://github.com/amibug/fly
* Copyright (c) 2015 wuyuedong; Licensed MIT */
!function(t){function e(e,n){this.$element=t(e),this.settings=t.extend(!0,{},i,n),this.init()}var i={version:"1.0.0",autoPlay:!0,vertex_Rtop:20,speed:1.2,start:{},end:{},onEnd:t.noop};e.prototype={init:function(){this.setOptions(),this.play()},setOptions:function(){var e=this.settings,i=e.start,n=e.end;this.$element.css({marginTop:"0px",marginLeft:"0px",position:"fixed"}).appendTo("body"),null!=n.width&&null!=n.height&&t.extend(!0,i,{width:this.$element.width(),height:this.$element.height()});var o=Math.min(i.top,n.top)-Math.abs(i.left-n.left)/3;o<e.vertex_Rtop&&(o=Math.min(e.vertex_Rtop,Math.min(i.top,n.top)));var h=Math.sqrt(Math.pow(i.top-n.top,2)+Math.pow(i.left-n.left,2)),s=Math.ceil(Math.min(Math.max(Math.log(h)/.05-75,30),100)/e.speed),a=i.top==o?0:-Math.sqrt((n.top-o)/(i.top-o)),p=(a*i.left-n.left)/(a-1),l=n.left==p?0:(n.top-o)/Math.pow(n.left-p,2);t.extend(!0,e,{count:-1,steps:s,vertex_left:p,vertex_top:o,curvature:l})},play:function(){this.settings.autoPlay&&this.move()},move:function(){var e=this.settings,i=e.start,n=e.count,o=e.steps,h=e.end,s=i.left+(h.left-i.left)*n/o,a=0==e.curvature?i.top+(h.top-i.top)*n/o:e.curvature*Math.pow(s-e.vertex_left,2)+e.vertex_top;if(null!=h.width&&null!=h.height){var p=o/2,l=h.width-(h.width-i.width)*Math.cos(p>n?0:(n-p)/(o-p)*Math.PI/2),r=h.height-(h.height-i.height)*Math.cos(p>n?0:(n-p)/(o-p)*Math.PI/2);this.$element.css({width:l+"px",height:r+"px","font-size":Math.min(l,r)+"px"})}this.$element.css({left:s+"px",top:a+"px"}),e.count++;var f=window.requestAnimationFrame(t.proxy(this.move,this));n==o&&(window.cancelAnimationFrame(f),e.onEnd.apply(this))},destroy:function(){this.$element.remove()}},t.fn.fly=function(t){return this.each(function(){new e(this,t)})}}(window.Zepto||window.jQuery);

// dragloader
!function(e){var t=e.document,o=e.navigator,r=o.msPointerEnabled,s={start:r?"MSPointerDown":"touchstart",move:r?"MSPointerMove":"touchmove",end:r?"MSPointerUp":"touchend"},n=function(){for(var e,o="t,webkitT,MozT,msT,OT".split(","),r=t.createElement("div").style,s=0,n=o.length;n>s;s++)if(e=o[s]+"ransform",e in r)return r=null,o[s].substr(0,o[s].length-1);return r=null,!1}(),i=function(e){return""===n?e:(e=e.charAt(0).toUpperCase()+e.substr(1),n+e)},a=i("transition"),h=function(){return"webkit"==n||"O"===n?n.toLowerCase()+"TransitionEnd":"transitionend"}(),d=function(e,t,o){var r=this,s=function(){e.transitionTimer&&clearTimeout(e.transitionTimer),e.transitionTimer=null,e.removeEventListener(h,n,!1)},n=function(){s(),o&&o.call(r)};s(),e.addEventListener(h,n,!1),e.transitionTimer=setTimeout(n,t+100)},l={threshold:80,dragDownThreshold:80,dragUpThreshold:80,dragDownClass:"dragger-down",dragUpClass:"dragger-up",dragUpDom:{before:"向下拉加载最新",prepare:"释放刷新",load:"加载中..."},dragDownDom:{before:"向上拉加载更多",prepare:"释放加载",load:"加载中..."}};e.DragLoader=function(e,o){var r=this;r.obj=e?"string"==typeof e?t.querySelector(e):e:t.body,o=o||{};for(var n in l)void 0===o[n]&&(o[n]=l[n]);r.options=o,r._events={},r._draggable=!0,r.obj.addEventListener(s.start,r,!1)},DragLoader.prototype={STATUS:{before:"before",prepare:"prepare",load:"load"},handleEvent:function(e){switch(e.type){case s.start:this._onTouchStrat(e);break;case s.move:this._onTouchMove(e);break;case s.end:this._onTouchEnd(e)}},_createDragDownRegion:function(){return this._removeDragDownRegion(),this.header=t.createElement("div"),this.header.className=this.options.dragDownClass,this._touchCoords.status=this._processStatus("down",0,null,!0),this.obj.insertBefore(this.header,this.obj.children[0]),this.header},_removeDragDownRegion:function(){this.header&&(this.obj.removeChild(this.header),this.header=null)},_createDragUpRegion:function(){return this._removeDragUpRegion(),this.footer=t.createElement("div"),this.footer.className=this.options.dragUpClass,this._touchCoords.status=this._processStatus("up",0,null,!0),this.obj.appendChild(this.footer),this.footer},_removeDragUpRegion:function(){this.footer&&(this.obj.removeChild(this.footer),this.footer=null)},_processDragDownHelper:function(e){var t=this;t.options.preventDragHelper||(t.header.innerHTML="<span>"+t.options.dragDownDom[e]+"</span>")},_processDragUpHelper:function(e){var t=this;t.options.preventDragHelper||(t.footer.innerHTML="<span>"+t.options.dragUpDom[e]+"</span>")},_processStatus:function(e,t,o,r){var s,n,i=this.options,a=this.STATUS,h=o;return e&&(n=e.charAt(0).toUpperCase()+e.substr(1),s=t>i["drag"+n+"Threshold"],s||o==a.before?r&&s&&o!=a.prepare?(this["_processDrag"+n+"Helper"].call(this,a.prepare),this._fireEvent("drag"+n+"Prepare"),h=a.prepare):!r&&s&&o!=a.load&&(this["_processDrag"+n+"Helper"].call(this,a.load),this._fireEvent("drag"+n+"Load"),h=a.load):(this["_processDrag"+n+"Helper"].call(this,a.before),this._fireEvent("drag"+n+"Default"),h=a.before)),h},_onTouchStrat:function(o){this.obj.removeEventListener(s.move,this,!1),this.obj.removeEventListener(s.end,this,!1),!this._draggable||this.options.disableDragDown===!0&&this.options.disableDragUp===!0||this._fireEvent("beforeDrag")===!1||(this._draggable=!1,this.obj.addEventListener(s.move,this,!1),this.obj.addEventListener(s.end,this,!1),this._touchCoords={},this._touchCoords.startY=r?o.screenY:o.touches[0].screenY,this._touchCoords.startScrollY=this.obj===t.body?e.pageYOffset||e.scrollY||t.documentElement.scrollTop:this.obj.scrollTop)},_onTouchMove:function(t){var o,s,n=this.obj,i=this.header,a=this.footer,h=this.options,d=e.innerHeight,l=n.scrollHeight,p=this._touchCoords,g=p.startScrollY,c=p.blockY,u=p.startY,f=r?t.screenY:t.touches[0].screenY;"undefined"==typeof p.canDragDown&&(p.canDragDown=h.disableDragDown!==!0&&f>u&&0>=g),"undefined"==typeof p.canDragUp&&(p.canDragUp=h.disableDragUp!==!0&&u>f&&g+d>=l),p.canDragDown&&p.dragUp!==!0&&(p.dragDown||0>u-f+g)?(t.preventDefault(),p.dragDown=!0,i||(i=this._createDragDownRegion()),"undefined"==typeof c&&(p.blockY=c=f),o=f-c,o=o>0?o:0,s=o-h.dragDownThreshold,s>100?o=h.dragDownThreshold+75+.25*(s-100):s>50&&(o=h.dragDownThreshold+50+.5*(s-50)),i.style.height=o+"px",p.status=this._processStatus("down",o,p.status,!0)):p.canDragUp&&p.dragDown!==!0&&(p.dragUp||u-f+g+d>l)?(t.preventDefault(),p.dragUp=!0,a||(a=this._createDragUpRegion()),"undefined"==typeof c&&(p.blockY=c=f),o=c-f,o=o>0?o:0,s=o-h.dragUpThreshold,s>100?o=h.dragUpThreshold+75+.2*(s-100):s>50&&(o=h.dragUpThreshold+50+.5*(s-50)),n.scrollTop=g+o,a.style.height=o+"px",p.status=this._processStatus("up",o,p.status,!0)):(this._draggable=!0,p.blockY=f)},_onTouchEnd:function(){this.obj.removeEventListener(s.move,this,!1),this.obj.removeEventListener(s.end,this,!1),this._translate()},_translate:function(){var e,t,o,r,s,n,i,h=this,l=h.options,p=h._touchCoords,g=200,c=function(){p.status=h._processStatus(e,o,p.status,!1),e&&p.status===h.STATUS.load?"down"==e?(h._removeDragUpRegion(),"function"==typeof l.dragDownLoadFn&&l.dragDownLoadFn.call(h)):"up"==e&&(h._removeDragDownRegion(),"function"==typeof l.dragUpLoadFn&&l.dragUpLoadFn.call(h)):(h._removeDragDownRegion(),h._removeDragUpRegion(),h._touchCoords=null,h._draggable=!0)};p&&(e=p.dragDown?"down":p.dragUp?"up":null,e?(t="down"==e?h.header:h.footer,o=t.offsetHeight,n=e.charAt(0).toUpperCase()+e.substr(1),i=l["drag"+n+"Threshold"],r=!l.preventDragHelper&&o>i?i:0,s=Math.ceil((o-r)/i*g),s=s>g?g:s,d(t,s,c),t.style[a]="height "+s+"ms",setTimeout(function(){t.style.height=r+"px"},0)):c())},reset:function(){this._translate()},on:function(e,t){this._events[e]||(this._events[e]=[]),this._events[e].push(t)},off:function(e,t){this._events[e]&&this._events[e].every(function(o,r){return o===t?(this._events[e].splice(r,1),!1):void 0})},_fireEvent:function(e,t){var o,r=this;return r._events[e]&&r._events[e].forEach(function(e){o=e.apply(r,t||[])}),o},setDragDownDisabled:function(e){this.options.disableDragDown=e},setDragUpDisabled:function(e){this.options.disableDragUp=e},destroy:function(){this.destroyed||(this.destroyed=!0,this._removeDragDownRegion(),this._removeDragUpRegion(),this.obj.removeEventListener(s.start,this,!1),this.obj.removeEventListener(s.move,this,!1),this.obj.removeEventListener(s.end,this,!1),this.obj=null)}}}(window);

// 气泡式弹出层
function popover(msg, delay) {
	var $ele = $('#popover');
	if (!msg) {
		return;
	}
	delay = delay || 2e3;
	if ($ele.length === 0) {
		$ele = $('<div />').attr({'id': 'popover', 'class': 'ui-popover'});
		$ele.appendTo($('body'));
	}

	$ele.html('<span class="txt">' + msg + '</span>').addClass('ui-popover-active');
	this.timer && clearTimeout(this.timer);
	this.timer = setTimeout(function() {
		$ele.removeClass('ui-popover-active');
	}, delay);
	setTimeout(function() {
		$ele.remove();
	}, 350 + delay);
}

// 获取链接参数
function getQueryStringArgs() {
    var qs      = location.search.length > 0 ? location.search.substring(1) : "",
        args    = {},
        items   = qs.length ? qs.split("&") : [],
        item    = null,
        name    = null,
        value   = null,
        i       = items.length - 1;

    for (; i >= 0; i--) {
        item = items[i].split("=");
        name = decodeURIComponent(item[0]);
        value = decodeURIComponent(item[1]);
        if (name.length > 1) {
            args[name] = value;
        };
    };
    return args;
}

/** 
 * @description 看大图 
 */
!(function($, win) {
    var defaults = {
        selector: '.thumb',
        weChatImagePreview: true
    };
    var $body = $('body');

	function Lightbox(options) {
		this.options = $.extend({}, defaults, options);
        this.currentImageIndex = 0;
        this.init();
	}
	Lightbox.prototype = {
        init: function() {
        	this.createDom();
        	this.bindEvent();
        },
        createDom: function() {
        	var model = [];
        	model.push('<div class="lightbox">');
        	model.push('<div class="hd">');
        	model.push('<i class="back"></i>');
        	model.push('<span class="num"></span>');
        	model.push('</div>');
        	model.push('<div class="bd">');
        	model.push('<ul></ul>');
        	model.push('</div>');
        	model.push('</div>');
        	$body.append(model.join(''));
        	this.$el = $('.lightbox');
        	this.$ul = this.$el.find('ul');
        	this.$num = this.$el.find('.num');
        },
        bindEvent: function() {
        	var that = this;
        	$body.on('click', that.options.selector + ' img', function() {
        		var src = this.src,
	            	index = 0,
	            	imgs = [];
	            $(this).closest(that.options.selector).find('img').each(function(i) {
	                imgs.push($(this).data('src') || this.src);
	                if (this.src === src) {
	                	index = i;
	                }
	            });
	            if (that.options.weChatImagePreview && win.WeixinJSBridge) {
	                win.WeixinJSBridge.invoke('imagePreview', {
	                    current: imgs[index],
	                    urls: imgs
	                });
	            } else {
	                that.play(imgs, index);
	            }
				return false;
			});

			that.$el.on('click', '.back', function() {
				that.$el.hide();
				$body.removeClass('no-scroll');
			})
        },
        play: function(album, index) {
        	var that = this,
        		model = [];
        	$.each(album, function(key, item) {
        		model.push('<li><img src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=" data-src="' + item + '"></li>')
        	})
        	that.$ul.html(model.join(''));
			that.$el.show();
			$body.addClass('no-scroll');

    		that.$ul.parent().swipeSlide({
                index: index,
                continuousScroll: true,
                autoSwipe: false,
                lazyLoad: true,
                firstCallback: function(i,sum){
                    that.$num.html(i+1 + ' / ' + sum);
                },
                callback: function(i,sum){
                    that.$num.html(i+1 + ' / ' + sum);
                }
            });
        }
    }

    win.lightbox = function(options) {
    	new Lightbox(options || {});
    }
})(window.Zepto||window.jQuery, window);

var _YYY = {
    CARTNAME: 'cartList', // 采购单存储key
    APPLYINFO: 'userInfo', // 申请寄样以及申请选货单提交的资料
    QUOTETIME:'quoteTime',//最近查看quote时间

    is_weixn: /MicroMessenger/.test(navigator.userAgent),

    timeago: {
        fillZero: function(number) {
            return number < 10 ? '0' + number : number;
        },
        format: function(t) {
            return t.getFullYear() + "-"
                + this.fillZero(t.getMonth() + 1) + "-"
                + this.fillZero(t.getDate()) + " " 
                + this.fillZero(t.getHours()) + ':' 
                + this.fillZero(t.getMinutes()); 
        },
        fullTime: function(e) {
            var t = new Date(e.replace(/-/g, '/'));
            return this.format(t);
        },
        shortDate: function(t) {
            return t.getFullYear() + "-"
                + this.fillZero(t.getMonth() + 1) + "-"
                + this.fillZero(t.getDate());
        },
        elapsedTime: function(e, shot) {
            var t = new Date(e.replace(/-/g, '/')),
                s = new Date,
                a = (s - t) / 1e3;
            return 10 > a ? "刚刚" : 60 > a ? Math.round(a) + "秒前" : 3600 > a ? Math.round(a / 60) + "分钟前" : 86400 > a ? Math.round(a / 3600) + "小时前" : (shot ? this.shortDate(t) : this.format(t))
        }
    },

    localstorage: {
        support: !!window.localStorage,
        get: function(key) {
            if (this.support && key) {
                return window.localStorage.getItem(key);
            } else {
                return null;
            }
        },
        set: function(key, val) {
            var self = this;
            if (this.support && key) {
                try {
                    window.localStorage.setItem(key, val);
                } catch (t) {
                    self.removeAll();
                    window.localStorage.setItem(key, val);
                }
            }
        },
        remove: function(key) {
            if (this.support && key) {
                window.localStorage.removeItem(key);
            }
        },
        removeAll: function() {
            if (this.support) {
                window.localStorage.clear();
            }
        }
    },

    verify: {
        isMobile: function(e) {
            return e && /^1[345678]\d{9}$/.test(e);
        },
        isEmpty: function(e) {
            return !e.length;
        }
    },

    share: {
        init: function(select) {
            this.insertHtml();
            this.bindEvent(select);
        },
        insertHtml: function() {
            var model = [];
            model.push('<div class="dialog-mask" id="jwxShare">');
            if (_YYY.is_weixn) {
                model.push('    <h2 class="hd">点击这里</h2>');
                model.push('    <p>然后点击 <em>【发送给朋友】</em> 或 <em>【分享到朋友圈】</em></p>');
                model.push('    <div class="guide"></div>');
            } else {
                model.push('    <p>找到浏览器的<em>分享按钮</em><br>然后点击 <em>【发送给朋友】</em> 或 <em>【分享到朋友圈】</em></p>');
            }
            model.push('</div>');
            $('body').append(model.join(''));
        },
        bindEvent: function(select) {
            $model = $('#jwxShare');
            select && $(select).on('click', function() {
                $model.show();
            })
            $model.on('click', function() {
                $model.hide();
            })
        }
    },

    regionArea: {
    	init: function(select) {
    		if (select) {
    			this.$body = $('body');
    			this.insertHtml();
	    		this.bindEvent(select);
    		}
    	},
    	insertHtml: function() {
    		var model = [];
    		model.push('<div class="ui-pick" id="jPick">');
    		model.push('<div class="ui-header">');
    		model.push('<div class="abs-l mid ico ico-back"></div>');
    		model.push('<div class="picked"><span></span><span></span><span></span></div>');
    		model.push('</div>');
    		model.push('<div class="options">');
    		model.push('<div class="cont">');
    		model.push('<ul></ul><ul></ul><ul></ul>');
    		model.push('</div>');
    		model.push('</div>');
    		model.push('</div>');
    		this.$body.append(model.join(''));
    	},
    	bindEvent: function(select) {
    		var that = this,
    			$pick = $('#jPick'),
                $tab = $pick.find('.picked'),
                $tabcont = $pick.find('.options'),
                $item = $pick.find('ul'),
                $cont = $pick.find('.cont'),
                $ipt = $(select),
                URL = '../json/area.php',
                tabtext = ['省', '市', '区/县'],
                region = ['', '', ''],
                cache = {};

	        var tab = function(idx) {
	            var distance = idx * $tabcont.width();
	            $item.css('position','absolute').eq(idx).css('position','relative');
	            $cont.css({
	                '-webkit-transition':'all .3s ease',
	                'transition':'all .3s ease',
	                '-webkit-transform':'translate3d(-' + distance + 'px,0,0)',
	                'transform':'translate3d(-' + distance + 'px,0,0)'
	            });

	        	$tab.find('span').each(function(i) {
	        		if (i > idx) {
	        			$(this).empty();
	        		} else {
						$(this).html(region[i] || tabtext[i]);
	        		}
	        	})
	        }

	        var getData = function(idx, pid) {
	        	if (cache[pid]) {
                    toHtml(cache[pid], idx);
	        		tab(idx);
	        	} else {
	        		$.ajax({
	                    url: URL,
	                    data: pid ? {parentId: pid} : {},
	                    dataType: 'json',
	                    success: function(res) {
	                        cache[pid] = res.data;
		                    toHtml(res.data, idx);
		                    tab(idx);
	                    }
	                })
	        	}
	        }

	        var toHtml = function(data, idx) {
	            var model = [];
	            $.each(data, function(i, item) {
	                model.push('<li data-id="', item.id ,'">', item.areaname, '</li>');
	            })
	            $item.eq(idx).html(model.join(''));
	        }

	        // 选择地区
	        $ipt.on('click', function() {
	        	that.$body.addClass('no-scroll');
	        	region = ['', '', ''];
	            getData(0);
	            $pick.show();
	        })

	        // 返回
	        $pick.on('click', '.ico-back', function() {
	            $pick.hide();
	        })

	        // tab
	        $tab.on('click', 'span', function() {
	            tab($(this).index());
	        })

	        // 城市级联
	        $tabcont.on('click', 'li', function() {
	            var idx = $(this).parent().index(),
                    text = this.innerHTML,
                    pid = $(this).data('id');

                $.each(region, function(i) {
                	if (i > idx) {
                		region[i] = '';
                	} else if (i == idx) {
                		region[idx] = text;
                	}
                })

	            if(idx == 2) {
	                $pick.hide();
	                $ipt.val(region.join('-')).prev().val(pid);
	                that.$body.removeClass('no-scroll');
	            } else {
	            	getData(idx + 1, pid);
	            }
	        })
    	}
        
    } 
}

// 显示商品数量
function showCommodityCount() {
    var cartName =  _YYY.localstorage.get(_YYY.CARTNAME);
    var arr = cartName === null ? [] : eval(cartName);
    var count = 0;
    $.each(arr, function(i, item) {
        count += parseInt(item.num, 10);
    })
    $('#cartNum').html(count === 0 ? '' : count);
}

// 商品数量
function pickCommodity(id, num){
    var cartName = _YYY.localstorage.get(_YYY.CARTNAME);

    if (isNaN(num)) {
        return;
    }

    if(cartName === null){
        //第一次添加,建立json结构。
         _YYY.localstorage.set(_YYY.CARTNAME,'[{commodityId:' + id + ', num:' + num + '}]');
    }else{
        var arr = eval(cartName),
            isNewCommodity = true; //判断是否已经追加

        //遍历所有对象。如果id相同，让该商品数量递增;
        $.each(arr, function(i, item) {
            if (item.commodityId == id) {
                item.num = parseInt(item.num, 10) + parseInt(num, 10);
                isNewCommodity = false;
                return false; // 跳出循环
            }
        })
        if (isNewCommodity) {
            arr.push({commodityId:id, num:num});
        }
        _YYY.localstorage.set(_YYY.CARTNAME, JSON.stringify(arr));
    }
    showCommodityCount();
}
// 更新商品数量
function updateCommodity(id, num) {
    var cartName =  _YYY.localstorage.get(_YYY.CARTNAME);
    var arr = cartName === null ? [] : eval(cartName);
    $.each(arr, function(i, item) {
        if (item.commodityId == id) {
            item.num = num;
            _YYY.localstorage.set(_YYY.CARTNAME, JSON.stringify(arr));
            return false; // 跳出循环
        }
    })
}

// 删除商品
function deleteCommodity(id) {
    var cartName =  _YYY.localstorage.get(_YYY.CARTNAME);
    var arr = cartName === null ? [] : eval(cartName);
    $.each(arr, function(i, item) {
        if (item.commodityId == id) {
            arr.splice(i, 1);
            _YYY.localstorage.set(_YYY.CARTNAME, JSON.stringify(arr));
            return false; // 跳出循环
        }
    })
    // showCommodityCount();
}

function getAppyInfo(){
    var userinfo = _YYY.localstorage.get(_YYY.APPLYINFO);
    if(userinfo !== null) {
        return eval('(' + userinfo + ')');
    } else {
        return null;
    }
}

function saveAppyinfo(info){
    var userinfo = _YYY.localstorage.get(_YYY.APPLYINFO);
    var arr = userinfo === null ? [] : eval('(' + userinfo + ')');

    if (arr.length !== 0 && arr.region && !info.region) {
        info.region = arr.region;
    }
    _YYY.localstorage.set(_YYY.APPLYINFO, JSON.stringify(info));
}
function deleteInfo() {
    _YYY.localstorage.remove(_YYY.APPLYINFO);
}

// 导航高亮
function navigationActive(){
    var $nav = $('.ui-footer'),
        URL = document.URL.split('#')[0].split('?')[0].toLowerCase();

    $nav.find('a').each(function() {
        var url = this.href.toLowerCase();
        if (URL === url) {
            $(this).addClass('current');
            return false; // break
        }
    })

    if (_YYY.is_weixn) {
        $('#center').attr('href', $('#center').attr('href') + "?source=WECHAT");
    }
}
// 导航高亮
function navLight(idx) {
    $('.footer').find('li').eq(idx).find('a').addClass('current');
}

// 搜索
function searchForm() {
    var $myform = $('#searchForm');
    if ($myform.length === 1) {
        $myform.on('click', '.submit', function() {
            var keywords = $(this).prev().val();
            alert(keywords)
        })
    }
}

$(function() {
    navigationActive();
    showCommodityCount();
    searchForm();
})