/**
 * jQuery方法扩展
 */
$.extend($.fn, {
	// 将form表单中的值序列化成对象
	serializeObject : function() {
		var o = {};
		$.each(this.serializeArray(), function(i) {
			if (o[this['name']]) {
				o[this['name']] = o[this['name']] + ',' + this['value'];
			} else {
				o[this['name']] = this['value'];
			}
		});
		return o;
	}
})