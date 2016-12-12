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
        var url = window.location.search; //获取url中"?"符后的字串
        var params = {};
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for(var i = 0; i < strs.length; i ++) {
                var name = strs[i].split("=")[0];
                var value = decodeURI(strs[i].split("=")[1]);
                $("[name="+name+"]").val(value);
            }
        }
        return params;
    }
    /**
     *
     */
    $.fn.code = function (code, val, call) {
        $that = $(this);
        $that.html("");
        $.post("/gen/code/"+code, function (result) {
            if (result.status == 200) {
                var html = "";
                $.each(result.data, function (k, v) {
                    html += '<option value="' + v.id + '">' + v.name + '</option>';
                })
                $that.html(html);
                if (val) {
                    $that.val(val);
                }
                if (call){
                    call();
                }
            }
        })
    }
})(jQuery);

!(function($){
    var defaults = {
        clickToHide: true   // 点击关闭
        ,delay: 3e3         // 3秒后自动关闭，为0时不关闭
        ,title: '提示消息'  // 文字
        ,text: ''           // 说明
        ,type: 'warn'       // 类型：错误(error)，正确(success)，警告(warn)
        ,call: null         // 关闭后回调
    }

    var icons = {
        error: '<i class="fa fa-times-circle"></i>'
        ,success: '<i class="fa fa-check-circle"></i>'
        ,warn: '<i class="fa fa-prompt"></i>'
    }
    var $wrapper;

    $.notify = function(options) {
        var settings = $.extend({}, defaults, options);
        var modal = [];
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
        typeof options.call === 'function' && options.call();
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
            $img.parent().find('img').each(function() {
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
                    marginLeft: -(imageWidth)/2,
                    marginTop: -(imageHeight)/2
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
    $window = $(window);
    var sidebar_height =  $('.aside').height();

    var fix = function() {
        $('.wrapper').css('min-height', Math.max($window.height(), sidebar_height));
    }

    $window.on('resize', fix);
    fix();
}

// 侧栏导航
function _aside() {
    var $aside = $('#jaside'),
        URL = document.URL.split('#')[0].split('?')[0].toLowerCase(),
        urlBefore = URL.split('/')[3];

    // 导航高亮
    $aside.find('a').each(function() {
        var url = this.href.toLowerCase(),
            hrefBefore = url.split('/')[3];

        if (URL === url) {
            $(this).addClass('current').closest('dl').addClass('active expand');
            return false; // break
        }
    }) 

    $aside.on('click', 'dt', function() {
        $(this).next().slideToggle()
        .parent().toggleClass('expand').siblings().removeClass('expand')
        .find('dd').slideUp();
    })

    // 以下代码本地专用
    $aside.html() === '' && $.ajax({
        url: 'inc/aside.html',
        success: function(innerHtml) {
            $aside.off().html(innerHtml);
            _aside();
        }
    })
}
// 相册弹层
function _showImg(url) {
    url && layer.open({
        type: 1,
        shade: .5,
        title: false, //不显示标题
        content: '<img src="' + url + '" alt="" />'
    });
}

// 修改密码
function modifyPwd() {
    var $trigger = $('#jmodifyPwd');
    if ($trigger.length === 0) {
        return;
    }
    $trigger.on('click', function() {
        layer.open({
            type: 2,
            area: ['470px', '250px'],
            title: '修改密码',
            content: 'modify_password.html'
        })
    })
}

$(function() {
    _fix();
    _aside();
    modifyPwd();

    $(document).ajaxError(function(event,request, settings){
        $.notify({
            type: 'error',
            title: "错误",   // 不允许的文件类型
            text: "系统内部错误",     //'支持 jpg、jepg、png、gif等格式图片文件',
            delay: 3e3
        });
    });
})