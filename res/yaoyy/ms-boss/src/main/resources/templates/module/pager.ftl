<#macro pager info url params>

<div class="pagination">
    <#if info.total gt 0>
    <div class="pages" id="pages">
        每页
        <select name="" class="slt">
            <option value="10">10</option>
            <option value="25">25</option>
            <option value="50">50</option>
            <option value="100">100</option>
        </select>
        <a id="pagePrev" href="javascript:;" class="text" data-index="${info.prePage}">上页</a>
        <#--比较:> , < , >= , <= (lt , lte , gt , gte)-->
        <#if (info.pageNum -info.firstPage) <= 3 && (info.lastPage -info.pageNum) <= 3 >
                <#list 1..info.pages as i>
                    <a href="javascript:;" data-index='${i}'>${i}</a>
                </#list>
            <#elseif  (info.pageNum -info.firstPage) <= 3 && (info.lastPage -info.pageNum) gt 3>
                <#list 1..(info.pageNum+1) as i>
                    <a href="javascript:;" data-index='${i}'>${i}</a>
                </#list>
                <i>...</i>
                <a href="javascript:;" data-index='${info.lastPage-1}'>${info.lastPage-1}</a>
                <a href="javascript:;" data-index='${info.lastPage}'>${info.lastPage}</a>
                <#--// 1- C+1 ... x-1, x-->
            <#elseif  (info.pageNum -info.firstPage) gt 3 && (info.lastPage -info.pageNum) gt 3>
                <a href="javascript:;" data-index='1'>1</a>
                <a href="javascript:;" data-index='2'>2</a>
                <i>...</i>
                <a href="javascript:;" data-index='${info.pageNum-1}'>${info.pageNum-1}</a>
                <a href="javascript:;" data-index='${info.pageNum}'>${info.pageNum}</a>
                <a href="javascript:;" data-index='${info.pageNum+1}'>${info.pageNum+1}</a>
                <i>...</i>
                <a href="javascript:;" data-index='${info.lastPage-1}'>${info.lastPage-1}</a>
                <a href="javascript:;" data-index='${info.lastPage}'>${info.lastPage}</a>
                <#--// 1,2 ... c-1,c,c+1 .. x-1,x-->
            <#elseif  (info.pageNum -info.firstPage) gt 3 && (info.lastPage -info.pageNum) <= 3>
                <a href="javascript:;" data-index='1'>1</a>
                <a href="javascript:;" data-index='2'>2</a>
                <i>...</i>
                <#list (info.pageNum-1)..info.lastPage as i>
                    <a href="javascript:;" data-index='${i}'>${i}</a>
                </#list>
                <#--// 1,2 ... c-1 - x-->
        </#if>
        <a id="pageNext" href="javascript:;" class="text" data-index="${info.nextPage}">下页</a>
    </div>
    </#if>
    <div class="info">
        显示第 ${info.startRow} 至 ${info.endRow} 项结果，共 <em id="pageSize">${info.total}</em> 项
    </div>
    <script>
        !(function($){
            var currentPage = ${info.pageNum};

            <#if info.isFirstPage>
            $('#pagePrev').addClass('disabled');
            </#if>
            <#if info.isLastPage>
            $('#pageNext').addClass('disabled');
            </#if>

            $('#pages').find('.slt').val('${info.pageSize}').on('change', function() {
                location.href = '${url}'+'?pageNum=${info.pageNum}&pageSize=' + this.value + '${(params)!}';
            })

            $('#pages').find('a[data-index="${info.pageNum}"]').addClass('curr');

            $('#pages').on('click', 'a', function () {
                var index = $(this).data('index');
                if (index == currentPage || index == 0) {
                    return;
                }
                location.href="${url}"+"?pageNum="+index+"&pageSize=${info.pageSize}${(params)!}"
            })
        })(jQuery);

    </script>
</div>
</#macro>

