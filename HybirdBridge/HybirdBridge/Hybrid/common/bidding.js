
$(function(){
	var default_page=Mproject.getUrlParameter("page")||1;
	//打开筛选
	$('.fun-search-filter').on('click',function(){
		var filter_h=$(window).height()-$('.filter-btn').height();
		$('.filter-content').css("height",filter_h+"px");
		$('.bidding-filter-main-bg').show();
		$('.bidding-filter-main').show().animate({right:'0%'},300);
		$(document.body).addClass("html-body-overflow");
		BackfillData();
	});

	//关闭筛选
	$('.fun-clear-filter').on('click',function(){
		$('.bidding-filter-main-bg').hide();
		$('.bidding-filter-main').animate({right:'-85%'},300);
		$(document.body).removeClass("html-body-overflow");
	});

	//窗口大小变动处理
	$(window).resize(function() {
		if($('.bidding-filter-main').is(':visible')){
			var filter_h=$(window).height()-$('.filter-btn').height();
			$('.filter-content').css("height",filter_h+"px");
			$('.bidding-filter-main-bg').css("height",$(window).height()+"px");
		}
	});

	//筛选数据回填
	function BackfillData(){
		var filter_areaNo=Mproject.getUrlParameter("areaNos"),
			filter_type=Mproject.getUrlParameter("type"),
			filter_tsid=Mproject.getUrlParameter("tsid"),
			$type=$('.filter-type'),
			$time=$('.filter-time'),
			$area=$('.filter-area');
		$('.filter-content').removeClass("element-selected");
		if(filter_type!=null){
			$('[data-type="'+filter_type+'"]',$type).addClass('element-selected');
		}else{
			$('span:first',$type).addClass('element-selected');
		}

		if(filter_tsid !=null){
			$('[data-tsid="'+filter_tsid+'"]',$time).addClass('element-selected');
		}else{
			$('span:first',$time).addClass('element-selected');
		}

		if(filter_areaNo!=null){
			if(filter_areaNo=="0001"){
				$('span',$area).addClass('element-selected');
			}else{

				var areaArray = filter_areaNo.split(",");
				for(var i=0;i<areaArray.length;i++){
					$('[data-area="'+areaArray[i]+'"]',$area).addClass('element-selected');
				}
				countArea();
			}
		}
	}
	//类型选择
	$('.filter-type span').on('click',function(){
		var _this=$(this),
			$father=_this.parents(".filter-ul");
		if(!_this.hasClass('element-selected')){
			$('span',$father).removeClass('element-selected');
			_this.addClass('element-selected');
		}

	})
	//时间段选择
	$('.filter-time span').on('click',function(){
		var _this=$(this),
			$father=_this.parents(".filter-ul");
		if(!_this.hasClass('element-selected')){
			$('span',$father).removeClass('element-selected');
			_this.addClass('element-selected');
		}
	})
	//地区统计
	function countArea(){
		var $ul=$('.filter-area ul'),
			selectedRow_num=0;
		$ul.each(function(){
			var _this=$(this),
				li_num=$('li',_this).length,
				selected_num=$('.element-selected',_this).length,
				first_selected=$('span:first',_this).hasClass('element-selected') ? 0:1;
			if(li_num>1 && li_num==selected_num+first_selected){
				$('span:first',_this).addClass('element-selected');
				selectedRow_num++;
			}else{
				$('span:first',_this).removeClass('element-selected');
			}
		});
		if(selectedRow_num==$ul.length-1){
			$('.filter-area-all').addClass('element-selected');
		}
	};

	//地区选择
	$('.filter-area span').on('click',function(){
		var _this=$(this);
		if(_this.hasClass('element-selected')){

			if(_this.hasClass('filter-area-all')){
				$('.filter-area span').removeClass('element-selected');
			}else if(_this.hasClass('filter-ul-first')){
				var $father=_this.parents(".filter-ul");
				$('span',$father).removeClass('element-selected');
			}else{
				_this.removeClass('element-selected');
			}

		}else{

			if(_this.hasClass('filter-area-all')){
				$('.filter-area span').addClass('element-selected');
			}else if(_this.hasClass('filter-ul-first')){
				var $father=_this.parents(".filter-ul");
				$('span',$father).addClass('element-selected');
			}else{
				_this.addClass('element-selected');
			}

		}
		countArea();
	});

	//筛选重置
	$('.fun-filter-reset').on('click',function(){
		var $type=$('.filter-type'),
			$time=$('.filter-time');
		$('.filter-content span').removeClass("element-selected");
		$('span:first',$type).addClass('element-selected');
		$('span:first',$time).addClass('element-selected');
	});

	//执行筛选
	$('.fun-filter-fulfil').on('click',function(){
		var $type=$('.filter-type'),
			$time=$('.filter-time'),
			$area=$('.filter-area'),
			kw=$('.bidding-search-kw').val(),
			type_selected_val=$('.element-selected',$type).attr('data-type'),
			time_selected_val=$('.element-selected',$time).attr('data-tsid'),
			area_selected_val="",
			condition="",
			area_val_Array=[];
		if($('.filter-area-all',$area).hasClass("element-selected")){
			var _val=$('.filter-area-all',$area).attr("data-area");
			area_val_Array.push(_val);
		}else{
			$('.element-selected',$area).each(function(){
				var _val=$(this).attr("data-area");
				if(_val!="" && _val){
					area_val_Array.push(_val);
				}
			});
		}

		if(area_val_Array.length>0){
			area_selected_val=area_val_Array.join(",");
		}

		if(kw!=""){
			condition+="kw="+kw+"&";
		}
		if(type_selected_val!=""){
			condition+="type="+type_selected_val+"&";
		}
		if(time_selected_val!=""){
			condition+="tsid="+time_selected_val+"&";
		}
		if(area_selected_val!=""){
			condition+="areaNos="+area_selected_val+"&";
		}
		if(condition!=""){
			condition=condition.substring(0,condition.length-1);
			location.href="/bidding/Search?"+condition;
		}else{
			location.href="/bidding/Search";
		}
	});
	$('.bidding-search-content input',name).on('focus',function(){
		$('.bidding-search-content').removeClass("search-input-bred")
		$(this).parent().addClass('search-input-bf80');
	});
	$('.bidding-search-content input',name).on('blur',function(){
		$(this).parent().removeClass('search-input-bf80');
	});
	$('.fun-setSearch').on('click',function(){
		var v_kw=$('.bidding-search-kw').val();
		if(v_kw && v_kw!=""){
			location.href="/bidding/Search?kw="+v_kw;
		}else{
			location.href="/bidding/Search";
		}
	});
	function getMoreData(){
		var o_main=$('.bidding-main'),
			_kw=$('[name="kw"]',o_main).val(),
			_type=Mproject.getUrlParameter("type")||"",
			_areaNos=Mproject.getUrlParameter("areaNos")||"",
			_tsid=Mproject.getUrlParameter("tsid")||"",
			postUrl="/bidding/Search?";
		default_page++;
		if(_kw!=""){
			postUrl+="kw="+_kw+"&";
		}
		if(_type!=""){
			postUrl+="type="+_type+"&";
		}
		if(_areaNos!=""){
			postUrl+="areaNos="+_areaNos+"&";
		}
		if(_tsid!=""){
			postUrl+="tsid="+_tsid+"&";
		}
		postUrl+="page="+default_page;
		$('.injectBiddingData').append('<li class="BiddingList-loading BiddingList-Loadprompt">火速加载中...</li>');
		$.ajax({
			url: postUrl,
			type: "post",
			dataType: "json",
			success: function (res) {
				if(res.Items.length>0){
					var _data=res.Items,
						_html="";
					for(var i in _data){
						var item=_data[i];
						_html+='<li><a href="/Bidding/Detail/'+item.bidID+'"><h2><span class="c-f60">['+item.bidType+']</span>'+item.bidName+'</h2><div class="bidding-other"><span class="fl c-01a67c">'+item.Area+'</span><span class="fr c-999">'+item.bidPubTime+'</span></div></a></li>';
					}
					$('.BiddingList-loading').replaceWith(_html).removeAttr("class");
					$(window).on('scroll', createScroll_fun);
				}else{
					$('.BiddingList-loading').html("已经到底了，再拉我就报警了-_-");
				}
			},
			error:function(xhr,status,statusText){
				alert(xhr.status)
			}
		});
	}
	//滚动条滚动底部加载数据
	var createScroll_fun=function(){
		var _this =$(this),
			viewH =_this.height(),			//可见高度
			contentH =$('body').height(),		//内容高度
			scrollTop =_this.scrollTop();		//滚动高度
		if(scrollTop/(contentH -viewH)>=0.95){ //到达底部100px时,加载新内容
			$(window).off('scroll', createScroll_fun);
			getMoreData();
		}
	};
	if($('.bidding-list .bidding-noContent').length==0){
		$(window).on('scroll', createScroll_fun);
	}
})
