function GalleryPhoto(guest_like_btn, like_form, share_btn, share_view) {
  this.guest_like_btn = guest_like_btn;
  this.like_form = like_form;
  this.share_btn = share_btn;
  this.share_view = share_view;
}

GalleryPhoto.prototype = {

  init: function() {
    //hide the sbuton for sharing images
    $('#send_invite_btn').hide();

    this.addEventHandlers();
  },

  set_form_param: function(like_button){
    this.like_form.find('#like_photo_id').val(like_button.data('photo-id'));
  },

  show_like_form: function() {
    this.like_form.modal('show');
  },

  close_like_form: function() {
    this.like_form.modal('hide');
  },

  show_share_view: function(current_button) {
    this.share_view.find('#share_image_url').val(current_button.data('image'));
    this.share_view.find('#image').attr('src', current_button.data('image'));
    this.share_view.modal('show');
  },

  addEventHandlers: function() {
    var that = this;

    this.guest_like_btn.click(function(){
      that.set_form_param($(this));
      that.show_like_form();
    });

    this.like_form.find('#like_photo_btn').click(function(){
      that.close_like_form();
    });

    this.share_btn.click(function() {
      that.show_share_view($(this));
    });
  }
}



$(document).on('page:change', function(){
  var guest_like_btn = $('button.guest_like_btn');
  var like_form = $('#like_photo_form');
  var share_view = $('#share_image_view');
  var share_btn = $('button.share_photo')

  var photo = new GalleryPhoto(guest_like_btn, like_form, share_btn, share_view);
  photo.init();
});
