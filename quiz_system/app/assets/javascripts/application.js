// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

function remove_question(link){	
	$(link).prev().val(true);
	$(link).parent().parent().parent().parent().next().hide();
	$(link).parent().parent().parent().parent().hide();
}

function remove_answer(link){	
	$(link).prev().val(true);
	$(link).parent().parent().parent().hide();
}

function add_fields(link, association, content){
	var p = $(link).parent();
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g");
	// $(link).parent().insert({
		// before: content.replace(regexp, new_id)
	// });
	$(content.replace(regexp, new_id)).insertBefore($(link));
}

function set_correct_answer(link){
	var question = $(link).parent().parent().parent().parent().parent().parent();
	clear_answer(question);
	$(link).prev().val(true);	
	button_behavior($(link), false);
}

function clear_answer(question) {
	if(question.children().size() > 0){
		var children = question.children();   
		children.each(function(){
			var child = $(this);
			clear_answer(child);
			if(child.attr('class') == 'answer_correct_flag'){
				child.val(false);
				button_behavior(child.next(), true);
			}
		});
	}
}

function button_behavior(button, enable){
	if(enable){
		button.removeClass("active btn-success");
	}
	else{
		button.addClass("active btn-success");
	}
}
