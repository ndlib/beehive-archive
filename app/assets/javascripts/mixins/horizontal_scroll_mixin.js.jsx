/** @jsx React.DOM */

var HorizontalScrollMixin = {
  setScroll: function() {
    if (event.pageX > this.box_right() && !this.state.scroll) {
      this.setState( { scroll: true });
      setTimeout(this.scroll, 50, 40);
    }
    else if (event.pageX < this.box_left() && !this.state.scroll) {
      this.setState( { scroll: true });
      setTimeout(this.scroll, 50, -40);
    }
    else if (event.pageX <= this.box_right() && event.pageX >= this.box_left() && this.state.scroll) {
        this.setState( { scroll: false } );
    }
  },

  scroll: function(speed) {
    if (this.state.scroll) {
      this.element().scrollLeft  += speed;
      setTimeout(this.scroll, 100, speed);
    }
  },
  element: function() {
    return document.getElementById('section-content-editor');
  },
  box_right: function() {
    return this.element().getBoundingClientRect().right - 100;
  },
  box_left: function() {
    return this.element().getBoundingClientRect().left + 100;
  },

};
