function GalleryPhoto(photo, guest_like_btn, like_form, share_btn, share_view) {
  this.photo = photo;
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

    this.setOverlayHeight();
  },

  setFormParam: function(like_button){
    this.like_form.find('#like_photo_id').val(like_button.data('photo-id'));
  },

  setOverlayHeight: function() {
    var that = this;
     $('#main-container').imagesLoaded(function(){
        that.photo.each(function(){
        var current_photo = $(this);
        var overlay = current_photo.find('.photo_img');
        console.log($(current_photo.find('.photo_img')).height());
        current_photo.find('.overlay').css({ "height": current_photo.find('.photo_img').height() })
      });
     });
    
    // this.photo.find('.overlay').css({'height':  "80%" }); //"" + $(this).find('.photo_img').attr('height')});
  },

  showLikeForm: function() {
    this.like_form.modal('show');
  },

  closeLikeForm: function() {
    this.like_form.modal('hide');
  },

  showShareView: function(current_button) {
    this.share_view.find('#share_image').val(current_button.data('photo-id'));
    this.share_view.find('#image').attr('src', current_button.data('image'));
    this.share_view.modal('show');
  },

  showDescription: function(currentPhoto) {
    currentPhoto.find('.overlay').switchClass('hidden', 'show-as-block');
  },

  addEventHandlers: function() {
    var that = this;

    this.guest_like_btn.click(function(){
      that.setFormParam($(this));
      that.showLikeForm();
    });

    this.like_form.find('#like_photo_btn').click(function(){
      that.closeLikeForm();
    });

    this.share_btn.click(function() {
      that.showShareView($(this));
    });
  }
}



$(document).on('page:change', function(){
  var photo = $('.gallery-item')
  var guest_like_btn = $('button.guest_like_btn');
  var like_form = $('#like_photo_form');
  var share_view = $('#share_image_view');
  var share_btn = $('button.share_photo')

  var photo = new GalleryPhoto(photo, guest_like_btn, like_form, share_btn, share_view);
  photo.init();
});
