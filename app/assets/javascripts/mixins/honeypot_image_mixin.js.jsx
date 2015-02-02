/** @jsx React.DOM */

var HoneypotImageMixin = {
  propTypes: {
    honeypot_image: React.PropTypes.object.isRequired,
    style: React.PropTypes.string,
  },
  getDefaultProps: function() {
    return {
      style: 'original'
    };
  },
  src: function() {
    return this.style().src;
  },
  style: function() {
    return _.find(this.props.honeypot_image.links.styles, function(style) {
      return style.id == this.props.style;
    }, this);
  },
};
