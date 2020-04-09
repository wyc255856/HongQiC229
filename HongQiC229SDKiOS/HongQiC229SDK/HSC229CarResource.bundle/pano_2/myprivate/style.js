(function() {
	//	移动式配问题
	var sp;
	sp_sp()
	window.onresize = function() {
		clearTimeout(sp);
		sp = setTimeout(function() {
			sp_sp();
		}, 500);
	}

	function sp_sp() {
		var deviceWidth = document.documentElement.clientWidth;
		//		if(deviceWidth > 640) {
		//			deviceWidth = 640
		//		}
		document.documentElement.style.fontSize = deviceWidth / 12.8 + 'px';
	}
	// 移动适配end

	//判断全景图加载完毕 执行自己的代码
	pano.on("imagesready", function() {
		myprivate()
		// $('.loding').hide()
		var loading = setTimeout(function() {
			$('.loding').hide()
			console.log("clearTimeout");
			clearTimeout(loading)
		}, 2000)
		console.log("Panorama imagesready!");
	});

	// console.log(pano.getIsLoaded())
	// 位置改变时
	pano.on("positionchanged", function() {
		// pano.getPan()
		// console.log(pano.isTouching())//当前是否在移动设备上触摸了全景播放器
		// console.log(pano.getLastVisitedNode())
		// $('.loding').hide()
	});


	function myprivate() {
		var host_1 = document.getElementsByClassName('host_1')[0];
		host_1.onclick = function(e) {
			if (e && e.stopPropagation) { //因此它支持W3C的stopPropagation()方法 
				e.stopPropagation();
			} else {
				//否则，我们需要使用IE的方式来取消事件冒泡 
				window.event.cancelBubble = true;
			}
			var anim = document.getElementsByClassName('anim')[0];
			// console.log(typeof anim)
			if (typeof anim == 'undefined') {
				//热点名称
				var host_list = [{
					'text': '一体屏',
					'id': '987'
				}, {
					'text': '屏幕',
					'id': '654'
				}, {
					'text': '亮度',
					'id': '321'
				}, {
					'text': '显示',
					'id': '987654'
				}, {
					'text': '屏幕',
					'id': '654321'
				}, {
					'text': '一体屏',
					'id': '321987'
				}];
				host_main(host_1, host_list)
			} else {
				anim.parentNode.removeChild(anim);
				return
			}
			var list_class = document.getElementsByClassName('list_class');
			for (var i = 0; i < list_class.length; i++) {
				list_class[i].index = i;
				list_class[i].onclick = function() {
					var host_id = this.getAttribute('data-id')
					// console.log(host_id)
					doJsTest(host_id)

				}
			}
		}
		var host_2 = document.getElementsByClassName('host_2')[0];
		host_2.onclick = function(e) {
			if (e && e.stopPropagation) { //因此它支持W3C的stopPropagation()方法
				e.stopPropagation();
			} else {
				//否则，我们需要使用IE的方式来取消事件冒泡 
				window.event.cancelBubble = true;
			}
			var anim = document.getElementsByClassName('anim')[0];
			// console.log(typeof anim)
			if (typeof anim == 'undefined') {
				//热点名称
				var host_list = [{
					'text': '一体屏2',
					'id': '123'
				}, {
					'text': '屏幕2',
					'id': '456'
				}, {
					'text': '亮度2',
					'id': '789'
				}, {
					'text': '显示2',
					'id': '123456'
				}, {
					'text': '屏幕2',
					'id': '456789'
				}, {
					'text': '一体屏2',
					'id': '789123'
				}];
				host_main(host_2, host_list)
			} else {
				anim.parentNode.removeChild(anim);
				return
			}

			var list_class = document.getElementsByClassName('list_class');
			for (var i = 0; i < list_class.length; i++) {
				// list_class[i].index = i;
				list_class[i].onclick = function() {
					var host_id = this.getAttribute('data-id')
					// console.log(host_id)
					doJsTest(host_id)

				}
			}
		}



		//安卓ios传数据
		function doJsTest(type) {
			var u = navigator.userAgent,
				app = navigator.appVersion;
			var isXiaomi = u.indexOf('XiaoMi') > -1; // 小米手机
			var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Linux') > -1; // 其它安卓
			var isIOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); // ios
			console.log(type)
			console.log(u)
			if (isIOS) {
				//JS给OC传值。'JsTest'为双方自定义的统一方法名；'type'为要传的值； response为OC收到后给JS的回调
				// bridge.callHandler('JsTest', type)
				//  "objc://"为自定义协议头;
				window.location.href = "objc://JsTest=" + type;
			} else {
				// 安卓
				window.Android.JsTest(type)
			}
		}

		//安卓端传数据
		// function doJsTest(type) {
		// 	console.log(type)
		// 	if (isIos()) {
		// 		//JS给OC传值。'JsTest'为双方自定义的统一方法名；'type'为要传的值； response为OC收到后给JS的回调
		// 		// bridge.callHandler('JsTest', type)
		// 		//  "objc://"为自定义协议头;
		// 		window.location.href = "objc://JsTest=" + type;
		// 	} else {
		// 		window.Android.JsTest(type)
		// 	}
		// }

		// // 判断安卓
		// function isAndroid() {
		// 	var u = navigator.userAgent;
		// 	if (u.indexOf("Android") > -1 || u.indexOf("Linux") > -1) {
		// 		if (window.ShowFitness !== undefined) return true;
		// 	}
		// 	return false;
		// }
		// // 判断设备为 ios
		// function isIos() {
		// 	var u = navigator.userAgent;
		// 	if (u.indexOf("iPhone") > -1 || u.indexOf("iOS") > -1) {
		// 		return true;
		// 	}
		// 	return false;
		// }
	}



	//热点弹窗模板
	function host_main(doc, text) {
		var host_wrapper = document.createElement("div"); //热点容器
		var host_line = document.createElement("div"); //热点弹出的线
		var host_list = document.createElement("div"); //热点的弹出框
		host_wrapper.classList.add('anim');
		host_line.classList.add('line');
		host_list.classList.add('list');
		host_list.classList.add('animated');

		// 判断热点位置调整弹窗位置
		var position_t = doc.getBoundingClientRect().top;
		var position_l = doc.getBoundingClientRect().left;
		var position_window_h = document.body.clientHeight;
		var position_window_w = document.body.clientWidth;

		if (position_t > position_window_h / 2 && position_l > position_window_w / 2) {
			//热点在右下	
			host_wrapper.style.transform = 'scale(1) rotateY(180deg) rotateX(0deg)';
			host_list.style.transform = 'scale(1) rotateY(180deg) rotateX(0deg)';
		} else if (position_t < position_window_h / 2 && position_l > position_window_w / 2) {
			//热点在右上
			host_wrapper.style.transform = 'scale(1) rotateY(180deg) rotateX(180deg)';
			host_list.style.transform = 'scale(1) rotateY(180deg) rotateX(180deg)';
		} else if (position_t < position_window_h / 2 && position_l < position_window_w / 2) {
			//热点在左上
			host_wrapper.style.transform = 'scale(1) rotateY(0deg) rotateX(180deg)';
			host_list.style.transform = 'scale(1) rotateY(0deg) rotateX(180deg)';
		} else if (position_t > position_window_h / 2 && position_l < position_window_w / 2) {
			//热点在左下
			host_wrapper.style.transform = 'scale(1) rotateY(0deg) rotateX(0deg)';
			host_list.style.transform = 'scale(1) rotateY(0deg) rotateX(0deg)';
		}
		var x_list_li = ''
		var x_list_li_text = text;
		for (var i = 0; i < x_list_li_text.length; i++) {
			x_list_li += `<li class="list_class" data-id="${x_list_li_text[i].id}">${x_list_li_text[i].text}</li>`;
		}
		var x_list = `<ul>${x_list_li}</ul>`
		host_list.innerHTML = x_list;
		host_wrapper.appendChild(host_line)
		host_wrapper.appendChild(host_list)
		doc.after(host_wrapper);


		//热点线动画 和弹窗动画
		$('.line').animate({
			width: "70px"
		}, function() {
			$('.list').fadeIn()
			// $('.list').addClass('bounceIn').show()
		});
		// 弹窗内滚动
		// $('.list div ul').dragscroll({
		// 	direction: 'scrollTop'
		// });
		// document.getElementsByClassName('list')[0].onclick = function() {
		// 	// console.log(1)
		// }
	}
	// $('.anim').on('click','li',function(){
	// 	console.log($(this).index())
	// })
})()
