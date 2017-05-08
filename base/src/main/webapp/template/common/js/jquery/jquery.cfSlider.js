

;(function($, window, document, undefined) {
	
	// plugin 이름, default option 설정
	var pluginName = 'cfSlider',
		defaults = {
			container: 'ul',	// 아이템들을 가지고 있는 엘리먼트의 jQuery 셀렉터
			item: 'li',				// 아이템 엘리먼트의 jQuery 셀렉터
			display: 1,					// 화면에 보여지는 아이템의 수
			move: 1,					// 한 번에 슬라이드될(이동할) 아이템의 수
			direction: 'horizontal',	// 가로슬라이드: horizontal, 세로슬라이드: vertical
			speed: 400,					// 슬라이딩 속도, 밀리세컨드 단위의 숫자 또는 jQuery.animate()에 사용가능한 'slow', 'fast' 등 문자열
			prevBtn: '.prev',			// 이전 버튼의 jQuery 셀렉터(꼭 버튼 형태일 필요 없음)
			nextBtn: '.next',			// 다음 버튼의 jQuery 셀렉터(꼭 버튼 형태일 필요 없음)
			eventType: 'click',			// slider를 작동시킬 때 필요한 이벤트. 즉, 이전/다음 버튼에 이 이벤트가 발생하면 slider 작동
			prevEventType: null,		// prev, next로 이동할 때 사용할 특별한 이벤트 타입 등록
			nextEventType: null,		// 활용예) 모바일웹 개발할 때 터치 swipe(플리킹)으로 slider를 작동시키고 싶으면 이 자리에 적절한
										// 커스텀 이벤트 타입을 등록하고, 터치를 할 때 그 커스텀 이벤트를 cfSlider를 실행시킬 엘리먼트에서 발생시키면 됨
			callback: null				// 슬라이드 애니메이션이 끝나고 실행될 콜백함수, 인자로 현재 화면에 보이고 있는 아이템들의 DOM객체를 받게 됨
			// callback: function(items) {
				// console.log(items);	// 이런 식으로 사용하시면 됩니다.
			// }
		};
	
	
	// plugin constructor
	function Plugin(element, options) {
		this.element = element;
		this.options = $.extend({}, defaults, options);
		
		this._defaults = defaults;
		this._name = pluginName;
		
		this.init();
	}
	
	
	// initialization logic
	Plugin.prototype.init = function() {
		
		var slider = $(this.element),
			options = this.options,
			$container = slider.find(options.container),
			$items = $container.find(options.item).not('.cfslider_clone'),
			itemLength = $items.length,
			$afterItems = $items.slice(0, options.display).clone(),		
			$beforeItems = $items.slice(itemLength - options.display, itemLength).clone(),	
			itemSize = options.direction === 'horizontal' ? $items.first().width() : $items.first().height(),	
			marginType = options.direction === 'horizontal' ? 'marginLeft' : 'marginTop',	
			$prevBtn = $(options.prevBtn),
			$nextBtn = $(options.nextBtn);
			
		this.container = $container;
		this.marginType = marginType;
		this.itemSize = itemSize;
		this.itemLength = itemLength;
		
		$beforeItems.each(function() {
			$(this).addClass('cfslider_clone');
		});
		
		$afterItems.each(function() {
			$(this).addClass('cfslider_clone');
		});
			
		slider.css('overflow', 'hidden');
		
		$container.empty();
		$container.append($beforeItems, $items, $afterItems);	

		var containerCss = {};
		containerCss['width'] = options.direction === 'horizontal' ? itemSize * (itemLength + options.display * 2) : itemSize;
		containerCss[marginType] = -(itemSize * options.display);
		
		$container.css(containerCss);
		

		$prevBtn
			.unbind(options.eventType + '.cfSlider')
			.bind(options.eventType + '.cfSlider', function() {
				go('prev', $container, marginType, itemSize, itemLength, options);
			});
	

		$nextBtn
			.unbind(options.eventType + '.cfSlider')
			.bind(options.eventType + '.cfSlider', function() {
				go('next', $container, marginType, itemSize, itemLength, options);
			});
		

		if (options.prevEventType) {
			slider
				.unbind(options.prevEventType + '.cfSlider')
				.bind(options.prevEventType + '.cfSlider', function() {
					go('prev', $container, marginType, itemSize, itemLength, options);
				});
		}
		
		if (options.nextEventType) {
			slider
				.unbind(options.nextEventType + '.cfSlider')
				.bind(options.nextEventType + '.cfSlider', function() {
					go('next', $container, marginType, itemSize, itemLength, options);
				});
		}
		
	};
	
	

	function go(direction, $container, marginType, itemSize, itemLength, options, currentMargin) {
		
		if ($container.is(':animated')) {	
			return;
		}
		
		var obj = {},	
			currentMargin = currentMargin === undefined ? parseInt($container.css(marginType)) : currentMargin;	
		
		if (direction === 'prev') {
			
			var targetMargin = currentMargin + itemSize * options.move;	
			
			obj[marginType] = targetMargin;
			

			$container.animate(obj, options.speed, function() {
				if ((Math.abs(currentMargin) / itemSize) <= (options.move > options.display ? options.move : options.display)) {
					targetMargin = targetMargin - (itemSize * itemLength);	
					$container.css(marginType, targetMargin);
				}
				
				if (options.callback != null) {
					var list = $container.find(options.item);
					options.callback(list.slice(Math.abs(targetMargin) / itemSize, Math.abs(targetMargin) / itemSize + options.display));
				}
			});
			
		} else if (direction === 'next') {
			
			var targetMargin = currentMargin - itemSize * options.move;		
			
			obj[marginType] = targetMargin;
			
			$container.animate(obj, options.speed, function() {
				if (itemLength + options.display * 2 - (Math.abs(currentMargin) / itemSize + options.display) <= (options.move > options.display ? options.move : options.display)) {
					targetMargin = targetMargin + (itemSize * itemLength);	
					$container.css(marginType, targetMargin);	
				}
				
				if (options.callback != null) {
					var list = $container.find(options.item);
					options.callback(list.slice(Math.abs(targetMargin) / itemSize, Math.abs(targetMargin) / itemSize + options.display));
				}
			});
			
		}
		
	}
	

	Plugin.prototype.go = go;
	
	$.fn[pluginName] = function(options) {
		
		return this.each(function() {
			
			if ( ! $.data(this, 'plugin_' + pluginName)) {
				$.data(this, 'plugin_' + pluginName, new Plugin(this, options));
			}
			
		});
		
	};
	
})(jQuery, window, document);



