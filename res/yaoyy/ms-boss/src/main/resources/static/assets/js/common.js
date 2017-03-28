/**
 * Created by kevin1 on 10/20/16.
 * 常用工具代码
 */
!(function($) {
    /**
     * 表单序列化为对象
     * @returns {{}}
     */
    $.fn.serializeObject = function(){
        var o = {};
        var a = this.serializeArray();
        $.each(a, function(){
            if (o[this.name]){
                if(!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    }

    /**
     * 获取参数值
     * @param name 参数名称
     * @returns
     */
    $.fn.getParamValue=function(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    /**
     * 获取参数列表
     * @returns {}
     */
    $.fn.getParams=function() {
        var url = window.location.search; //获取url中"?"符后的字串
        var params = {};
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for(var i = 0; i < strs.length; i ++) {
                params[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
            }
        }
        return params;
    }

    /**
     * 把url 后面的参数赋值到对应表单
     * @returns {{}}
     */
    $.fn.initByUrlParams=function() {
        var $this = $(this);
        var url = window.location.search; //获取url中"?"符后的字串
        var params = {};
        if (url.indexOf('?') != -1) {
            var str = url.substr(1).split('&');
            for(var i = 0; i < str.length; i ++) {
                var name = str[i].split("=")[0];
                var value = decodeURI(str[i].split("=")[1]);
                $this.find("[name="+name+"]").val(value);
            }
        }
        return params;
    }
    /**
     *
     */
    $.fn.code = function (code, val, call) {
        var $that = $(this);
        $that.empty();
        $.post('/gen/code/' + code, function (res) {
            if (res.status == 200) {
                var model = [];
                $.each(res.data, function (key, item) {
                    model.push('<option value="' + item.id + '">' + item.name + '</option>');
                })
                $that.html(model.join(''));
                val && $that.val(val);
                typeof call === 'function' && call();
            }
        })
    }
})(jQuery);

var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

layer.config({
    moveType: 1,
    success : function() {
        isMobile && $('body').addClass('no-scroll');
        // $('.layui-layer-content').height('auto');
    },
    end: function() {
        isMobile && $('body').removeClass('no-scroll');
    }
});

!(function($){
    var defaults = {
        clickToHide: true   // 点击关闭
        ,delay: 1e3         // 1秒后自动关闭，为0时不关闭
        ,title: '提示消息'  // 文字
        ,text: ''           // 说明
        ,type: 'warn'       // 类型：错误(error)，正确(success)，警告(warn)
        ,call: null         // 关闭后回调
    }

    var icons = {
        error: '<i class="fa fa-times-circle"></i>'
        ,success: '<i class="fa fa-check-circle"></i>'
        ,warn: '<i class="fa fa-exclamation-circle"></i>'
    }
    var $wrapper;

    $.notify = function(options) {
        var settings = $.extend({}, defaults, options);
        var modal = [];
        if (isMobile) {
            layer.msg(options.title + (options.text ? options.text : ''), {offset: '80%', success: function() {$('body').removeClass('no-scroll');}});
            return false;
        }

        modal.push('<div class="message ', settings.type, settings.clickToHide ? ' hidable' : '', '">');
        modal.push(    '<div class="inner">');
        modal.push(        '<div class="icon">');
        modal.push(            icons[settings.type]);
        modal.push(        '</div>');
        modal.push(        '<div class="text', (settings.text ? '' : ' mid') , '">');
        modal.push(            '<h3>', settings.title, '</h3>');
        modal.push(            '<p>', settings.text, '</p>');
        modal.push(        '</div>');
        modal.push(    '</div>');
        modal.push('</div>');

        var $modal = $(modal.join(''));
        if (typeof $wrapper === 'undefined') {
            $wrapper = $('<div class="notify-wrapper"></div>').appendTo($('body'));
        }
        $wrapper.prepend($modal);
        if (settings.delay === 0) {
            $modal.slideDown(400);

        } else {
            $modal.slideDown(400).delay(settings.delay).slideUp(200, function() {
                $modal.remove();            
            });
        }
        if (typeof settings.callback === 'function') {
            setTimeout(function() {
                settings.callback();
            }, settings.delay)
        }
    };

    // 点击关闭
    $('body').on('click', '.hidable', function() {
        var $self = $(this);
        $self.stop().slideUp(200, function() {
            $self.remove();
        });
    })
})(jQuery);

// lightbox 图片插件
!(function($, window) { 
    var defaults = {
        selector: '.thumb',
        albumLabel: '<span>%1 / %2</span>',
        fadeDuration: 300,
        resizeDuration: 100
    };
    var $body = $('body'),
        $window = $(window);

    function Lightbox(options) {
        this.options = $.extend({}, defaults, options);
        this.currentImageIndex = 0;
        this.init();
    }

    Lightbox.prototype = {
        init: function() {
            this.getSize().resize().enable().build();
        },
        resize: function() {
            var self = this,
                timer;

            var winResize = function () {
                if (self.album) {
                    timer && clearTimeout(timer);
                    timer = setTimeout(function () {
                        self.getSize();
                        self.changeImage(self.currentImageIndex);
                    }, self.options.resizeDuration);
                }
            };
            $window.on('resize.lightbox', winResize);
            return this;
        },
        getSize: function() {
            this.windowWidth = $(window).width();
            this.windowHeight = $(window).height();
            return this;
        },
        enable: function() {
            var self = this;
            $(self.options.selector).on('click', 'img', function() {
                self.start($(this));
                return false;
            })
            return this;
        },
        build: function() {
            var self = this;
            $('<div id="lightboxOverlay" class="lightboxOverlay"></div><div id="lightbox" class="lightbox"><div class="lb-nav"></div><div class="lb-thumb"><img class="lb-image" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="/><span class="lb-prev"></span><span class="lb-next"></span></div><div class="lb-loader"></div><div class="lb-close" title="关闭"></div></div>').appendTo($('body'));
            this.$lightbox = $('#lightbox');
            this.$overlay = $('#lightboxOverlay');
            self.$image = this.$lightbox.find('.lb-image');
            self.$loader = this.$lightbox.find('.lb-loader');
            self.$nav = this.$lightbox.find('.lb-nav');
            this.$overlay.on('click', function() {
                self.end();
                return false;
            });
            this.$lightbox.on('click', '.lb-close', function() {
                self.end();
                return false
            })
            this.$lightbox.on('click', '.lb-prev', function() {
                if (self.currentImageIndex === 0) {
                    self.changeImage(self.album.length - 1)
                } else {
                    self.changeImage(self.currentImageIndex - 1)
                }
                return false
            });
            this.$lightbox.on('click', '.lb-next', function() {
                if (self.currentImageIndex === self.album.length - 1) {
                    self.changeImage(0)
                } else {
                    self.changeImage(self.currentImageIndex + 1)
                }
                return false
            });
            return this;
        },
        start: function($img) {
            var self = this;
            self.album = [];
            $img.closest(self.options.selector).find('img').each(function() {
                self.album.push({
                    url: $(this).data('src') || this.src,
                    preloader: false
                });
            }); 
            this.$image.siblings()[self.album.length < 2 ? 'hide' : 'show']();
            this.$overlay.fadeIn(this.options.fadeDuration);
            this.$lightbox.fadeIn(this.options.fadeDuration);
            this.changeImage($img.index());
        },
        changeImage: function(current) {
            var self = this;
            self.$loader.fadeIn('slow');
            self.$image.hide();

            var img = new Image();
            img.onload = function() {
                var imageHeight = img.height; 
                var imageWidth = img.width;     
                var windowHeight = self.windowHeight - 120;
                var windowWidth = self.windowWidth - 20;
                var maxImageHeight = self.options.maxHeight || windowHeight; 
                var maxImageWidth = self.options.maxWidth || windowWidth; 
                img.onload = null;

                maxImageHeight = Math.min(maxImageHeight, windowHeight);
                maxImageWidth = Math.min(maxImageWidth, windowWidth);

                if ((imageWidth > maxImageWidth) || (imageHeight > maxImageHeight)) {
                    if ((imageWidth / maxImageWidth) > (imageHeight / maxImageHeight)) {
                        imageHeight = parseInt(imageHeight * maxImageWidth / imageWidth, 10);
                        imageWidth = maxImageWidth;
                    } else {
                        imageWidth = parseInt(imageWidth * maxImageHeight / imageHeight, 10);
                        imageHeight = maxImageHeight;
                    }
                }

                imageWidth = Math.max(300, imageWidth);
                imageHeight = Math.max(300, imageHeight);

                self.$lightbox.animate({
                    width: imageWidth,
                    height: imageHeight,
                    marginLeft: -(imageWidth + 8)/2,
                    marginTop: -(imageHeight + 8)/2
                }, self.options.fadeDuration, 'swing', function() {
                    self.$image.attr({
                        'src': self.album[current].url,
                        'width': imageWidth,
                        'height': imageHeight
                    }).fadeIn();

                    self.$loader.stop(true).hide();
                });
            };
            img.src = self.album[current].url;
            self.currentImageIndex = current;
            self.preloadNeighboringImages();
            self.showNav();

        },
        preloadNeighboringImages: function() {
            if (this.album.length > this.currentImageIndex + 1) {
                var preloadNext = new Image();
                preloadNext.src = this.album[this.currentImageIndex + 1].url
            }
            if (this.currentImageIndex > 0) {
                var preloadPrev = new Image();
                preloadPrev.src = this.album[this.currentImageIndex - 1].url
            }
        },
        showNav: function() {
            var labelText = this.imageCountLabel(this.currentImageIndex + 1, this.album.length);
            this.$nav.html(labelText);
        },
        imageCountLabel: function(currentImageNum, totalImages) {
            return this.options.albumLabel.replace(/%1/g, currentImageNum).replace(/%2/g, totalImages);
        },
        end: function() {
            this.$lightbox.fadeOut(this.options.fadeDuration);
            this.$overlay.fadeOut(this.options.fadeDuration);
        }
    }
    $(function() {
        new Lightbox();
    })
})(jQuery, window);


// 页面布局
function _fix() {
    var $window = $(window);
    var sidebar_height =  $('.aside').height();

    var fix = function() {
        $('.wrapper').css('min-height', Math.max($window.height(), sidebar_height));
    }

    $window.on('resize', fix);
    fix();
}

function navLight(idx) {
    $('#navItem' + idx).addClass('current').closest('dl').addClass('active expand').siblings().removeClass('active expand');
}


// 侧栏导航
function _sidebar() {
    var $sidebar = $('.sidebar'),
        URL = document.URL.split('#')[0].split('?')[0].toLowerCase(),
        urlBefore = URL.split('/')[3];

    // 导航高亮
    $sidebar.find('a').each(function() {
        var url = this.href.toLowerCase(),
            hrefBefore = url.split('/')[3];

        if (URL === url) {
            $(this).addClass('current').closest('dl').addClass('active expand');
            return false; // break
        }
        if(urlBefore === hrefBefore){
            $(this).closest('dl').addClass('active expand');
        }
    }) 

    $sidebar.on('click', 'dt', function() {
        $(this).next().slideToggle()
        .parent().toggleClass('expand').siblings().removeClass('expand')
        .find('dd').slideUp();
    })

    if (isMobile) {
        $('.filter').after('<div class="fa fa-filter filter-toggle"></div>');

        $('.sidebar-toggle').on('click', function(){
            $('.wrapper').toggleClass('wrapper-open');
        })

        $('.filter-toggle').on('click', function(){
            $('.tools').toggleClass('tools-open');
            return false;
        })

        $('.content').on('click', function() {
            $('.wrapper').removeClass('wrapper-open');
        })        
    }
}

// 修改密码
function _modifyPwd() {
    var $trigger = $('#jmodifyPwd');
    if ($trigger.length === 0) {
        return;
    }
    $trigger.on('click', function() {
        layer.open({
            skin: 'layer-form',
            type: 2,
            area: ['300px', '220px'],
            title: '修改密码',
            content: '/member/changePassword'
        })
    })
}

// 消息提醒
function _newMsg(notification) {
    $.post('/msg/list', function (result) {
        if (result.status == 200) {
            var model = [],
                temp = [],
                count = result.data.count || '';
            $.each(result.data.list,function(i, item){
                model.push('<a href="', item.url, '">', item.content, '</a>');
                temp.push(item.content);
                if (i > 8) {
                    return false;
                }
            })
            $('#msgList').html(model.join(''));
            if (count) {
                $('#newsNum').html(count).show();
                !isMobile && notification && showNotification({
                    title: '药优优消息',
                    body: temp.join('，')
                });
            } else {
                $('#newsNum').empty().hide();
            }
        }
    })
    // 5分钟请求一次
    setTimeout(function() {
        _newMsg(true);
    }, 3e5);
}

// 桌面提醒
function showNotification(options) {
    if (!window.Notification || !options) {
        return;
    }
    Notification.requestPermission(function() {}); // 获取权限

    var defaults = {
        body: options.body || '',
        icon: options.icon || 'http://boss.yaobest.com/assets/images/slogan.png',
        tag: options.tag || (new Date).getTime()
    }
    if (defaults.body.length > 40) {
        defaults.body = defaults.body.substring(0, 37) + '...';
    }
    var t = new Notification(options.title || '消息', defaults);

    t.onshow = function(){
        $('body').append('<audio src="assets/media/voice.mp3" id="notification-audio" preload="auto" autoplay></audio>');
    }
    setTimeout(function() {
        $('#notification-audio').remove();
        t.close();
    }, options.delay || 5e3);
}

// 全选
function _checkbox() {
    var $table = $('.table'),
        $cbx = $table.find('td input:checkbox'),
        $checkAll = $table.find('th input:checkbox'),
        count = $cbx.length;

    // 全选
    $checkAll.on('click', function() {
        var isChecked = this.checked;
        $cbx.each(function() {
            this.checked = isChecked;
        })
    })
    // 单选
    $cbx.on('click', function() {
        var _count = 0;
        $cbx.each(function() {
            _count += this.checked ? 1 : 0;
        })
        $checkAll.prop('checked', _count === count);
    })
}

// 搜索
function _filter() {
    var $form = $('#filterForm');

    if ($form.length === 1) {
        var $ipts = $form.find('.ipt, .slt');

        $form.initByUrlParams(); // 回填表单value

        $form.on('submit', function() {
            var params = [];
            $ipts.each(function() {
                var val = $.trim(this.value);
                val && params.push(this.name + '=' + val);
            })
            window.location.href = $form.attr('action') + (params.length ? '?' + params.join('&') : '');
            return false;
        })
    }
}

$(function() {
    _fix();
    _sidebar();
    _newMsg();
    _modifyPwd();
    // _checkbox(); 
    _filter();
    $(document).ajaxError(function(event,request, settings){
        $.notify({
            type: 'error',
            title: '错误',
            text: '网络错误'
        });
    });
})