<#macro pager info url params>
<script>
    function gotopage(pageSize){
        window.location.href = '${url}?pageNum=${info.pageNum}&pageSize=' + pageSize + '${(params)!}';
    }
</script>
<div class="pagination">
    <#if info.total gt 0>
    <div class="pages">
        每页
        <select onchange="gotopage(this.value)" class="slt">
            <option value="10" <#if info.pageSize == 10>selected</#if>>10</option>
            <option value="25" <#if info.pageSize == 25>selected</#if>>25</option>
            <option value="50" <#if info.pageSize == 50>selected</#if>>50</option>
            <option value="100" <#if info.pageSize == 100>selected</#if>>100</option>
        </select>

        <#if info.isFirstPage>
            <span class="text disabled">上页</span>
        <#else>
            <a href="${url}?pageNum=${info.prePage}&amp;pageSize=${info.pageSize}${(params)!}" class="text">上页</a>
        </#if>

        <#if (info.pageNum -info.firstPage) <= 3 && (info.lastPage -info.pageNum) <= 3 >
            <#list 1..info.pages as i>
                <#if info.pageNum ==  i>
                    <span class="curr" k="1">${i}</span>
                <#else>
                    <a href="${url}?pageNum=${i}&amp;pageSize=${info.pageSize}${(params)!}">${i}</a>
                </#if>
            </#list>

        <#elseif  (info.pageNum -info.firstPage) <= 3 && (info.lastPage -info.pageNum) gt 3>
            <#list 1..(info.pageNum+1) as i>
                <#if info.pageNum ==  i>
                    <span class="curr" k="2">${i}</span>
                <#else>
                    <a href="${url}?pageNum=${i}&amp;pageSize=${info.pageSize}${(params)!}">${i}</a>
                </#if>
            </#list>
            <i>...</i>
            <a href="${url}?pageNum=${info.lastPage-1}&amp;pageSize=${info.pageSize}${(params)!}">${info.lastPage-1}</a>
            <a href="${url}?pageNum=${info.lastPage}&amp;pageSize=${info.pageSize}${(params)!}">${info.lastPage}</a>

        <#elseif  (info.pageNum -info.firstPage) gt 3 && (info.lastPage -info.pageNum) gt 3>
            
            <a href="${url}?pageNum=1&amp;pageSize=${info.pageSize}${(params)!}">1</a>
            <a href="${url}?pageNum=2&amp;pageSize=${info.pageSize}${(params)!}">2</a>
            <i>...</i>
            <a href="${url}?pageNum=${info.pageNum-1}&amp;pageSize=${info.pageSize}${(params)!}">${info.pageNum-1}</a>
            <span class="curr" k="3">${info.pageNum}</span>
            <a href="${url}?pageNum=${info.pageNum+1}&amp;pageSize=${info.pageSize}${(params)!}">${info.pageNum+1}</a>
            <i>...</i>
            <a href="${url}?pageNum=${info.lastPage-1}&amp;pageSize=${info.pageSize}${(params)!}">${info.lastPage-1}</a>
            <a href="${url}?pageNum=${info.lastPage}&amp;pageSize=${info.pageSize}${(params)!}">${info.lastPage}</a>

        <#elseif  (info.pageNum -info.firstPage) gt 3 && (info.lastPage -info.pageNum) <= 3>
            <a href="${url}?pageNum=1&amp;pageSize=${info.pageSize}${(params)!}">1</a>
            <a href="${url}?pageNum=2&amp;pageSize=${info.pageSize}${(params)!}">2</a>
            <i>...</i>
            <#list (info.pageNum-1)..info.lastPage as i>
                <#if info.pageNum ==  i>
                    <span class="curr" k="4">${i}</span>
                <#else>
                    <a href="${url}?pageNum=${i}&amp;pageSize=${info.pageSize}${(params)!}">${i}</a>
                </#if>
            </#list>
        </#if>

        <#if info.isLastPage>
            <span class="text disabled">下页</span>
        <#else>
            <a href="${url}?pageNum=${info.nextPage}&amp;pageSize=${info.pageSize}${(params)!}" class="text">下页</a>
        </#if>

    </div>
    </#if>
    <div class="info">
        显示第 ${info.startRow} 至 ${info.endRow} 项结果，共 <em>${info.total}</em> 项
    </div>
</div>
</#macro>

