;(function(win,$){
    'use strict';

    var zIndex = 1;
    
    // 触摸事件
    var events = ['touchstart','touchmove','touchend'];
    // 检测
    var support = {
        // 触摸
        touch : (win.Modernizr && Modernizr.touch === true) || (function () {
            return !!(('ontouchstart' in win) || win.DocumentTouch && document instanceof DocumentTouch);
        })()
    };


    // 触摸赋值
    var touchEvents = {
        touchStart : events[0],
        touchMove : events[1],
        touchEnd : events[2]
    };

    // 绑定swipeSlide
    $.fn.swipeSlide = function(options){
        var list = [];
        this.each(function(i, me){
            list.push(new sS(me, options));
        });
        return list;
    };
    var sS = function(element, options){
        var me = this;
        me.$el = $(element);
        me._distance = 50;
        me.init(options);
    };

    // 初始化
    sS.prototype.init = function(options){
        var me = this;
        me.opts = $.extend({}, {
            li : me.$el.children('.page'),  // 子dom
            index : 0,                              // 轮播初始值
            continuousScroll : true,               // 连续滚动
            speed : 4000,                           // 切换速度
            axisX : false,                           // X轴
            transitionType : 'ease',                // 过渡类型
            firstCallback : function(){},           // 页面加载回调
            callback : function(){}                 // 每次滚动回调
        }, options);
        me._index = me.opts.index;
        // 轮播数量
        me._liLength = me.opts.li.length;
        me.isScrolling;

        // 回调
        me.opts.firstCallback(me._index,me._liLength,me.$el);

        // 如果轮播小于等于1个，跳出
        if(me._liLength <= 1){
            return false;
        }

        // 轮播的宽度
        fnGetSlideDistance();

        // 绑定触摸
        me.$el.on(touchEvents.touchStart,function(e){
            fnTouches(e);
            fnTouchstart(e, me);
        });
        me.$el.on(touchEvents.touchMove,function(e){
            fnTouches(e);
            fnTouchmove(e, me);
        });
        me.$el.on(touchEvents.touchEnd,function(){
            fnTouchend(me);
        });
        me.opts.li.on('webkitTransitionEnd MSTransitionEnd transitionend',function(){
            me.opts.li.eq()
        });

        // 横竖屏、窗口调整
        $(win).on('onorientationchange' in win ? 'orientationchange' : 'resize',function(){
            clearTimeout(me.timer);
            me.timer = setTimeout(fnGetSlideDistance, 150);
        });
        
        // 获取轮播宽度
        function fnGetSlideDistance(){
            me._slideDistance = me.opts.axisX ? me.$el.width() : me.$el.height();
        }
    };

    // touches
    function fnTouches(e){
        if(support.touch && !e.touches){
            e.touches = e.originalEvent.touches;
        }
    }

    // touchstart
    function fnTouchstart(e, me){
        me.isScrolling = undefined;
        me._moveDistance = 0;
        // 按下时的坐标
        me._startX = support.touch ? e.touches[0].pageX : (e.pageX || e.clientX);
        me._startY = support.touch ? e.touches[0].pageY : (e.pageY || e.clientY);
    }

    // touchmove
    function fnTouchmove(e, me){
        // 触摸时的坐标
        me._curX = support.touch ? e.touches[0].pageX : (e.pageX || e.clientX);
        me._curY = support.touch ? e.touches[0].pageY : (e.pageY || e.clientY);
        // 触摸时的距离
        me._moveX = me._curX - me._startX;
        me._moveY = me._curY - me._startY;
        // 优化触摸禁止事件
        if(typeof me.isScrolling == 'undefined'){
            if(me.opts.axisX){
                me.isScrolling = !!(Math.abs(me._moveX) >= Math.abs(me._moveY));
            }else{
                me.isScrolling = !!(Math.abs(me._moveY) >= Math.abs(me._moveX));
            }
        }
        
        // 距离
        if(me.isScrolling){
            if (e.preventDefault) e.preventDefault();
            else e.returnValue = false;
            // 触摸时跟手
            me._moveDistance = me.opts.axisX ? me._moveX : me._moveY;
        }
        if(!me.opts.continuousScroll){
            // 如果是第一屏，并且往下滚动，就不让滚动 || 如果是最后一屏，并且往上滚动，就不让滚动
            if(me._index == 0 && me._moveDistance > 0 || (me._index + 1) >= me._liLength && me._moveDistance < 0){
                me._moveDistance = 0;
            }
        }
    }

    // touchend
    function fnTouchend(me){
        if(Math.abs(me._moveDistance) >= me._distance){
            // 手指触摸上一屏滚动
            if(me._moveDistance > me._distance){
                fnSlide(me, 'prev');
            // 手指触摸下一屏滚动
            }else if(Math.abs(me._moveDistance) > me._distance){
                fnSlide(me, 'next');
            }
        }
        me._moveDistance = 0;
    }

    // 轮播方法
    function fnSlide(me, go){
        // 判断方向
        if(go == 'next'){
            me.opts.li.eq(me._index).addClass('prev').removeClass('slideInUp').siblings().removeClass('prev').removeClass('slideInDown');
            me._index++;
            if (me._index >= me._liLength) {
                me._index = 0;
            }
            me.opts.li.eq(me._index).addClass('slideInUp');
        }else if(go == 'prev'){
            me.opts.li.removeClass('slideInUp slideInDown prev').eq(me._index).addClass('slideInDown');
            if (me._index <= 0) {
                me._index = me._liLength - 1;
                me.opts.li.eq(me._index).addClass('prev');
            } else {
                me.opts.li.eq(me._index-1).addClass('prev');
                me._index --;
            }
        }
    }

})(window, window.Zepto || window.jQuery);