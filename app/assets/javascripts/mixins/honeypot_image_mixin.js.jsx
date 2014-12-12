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
  path: function () {
    return "/images/" + this.style().path
  },
  uri: function() {
    return this.base_uri() + this.path();
  },
  base_uri: function() {
    if (this.props.honeypot_image.host == 'localhost') {
      return "http://localhost:3019";
    } else {
      return window.location.protocol + "//" + this.props.honeypot_image.host;
    }
  },
  style: function() {
    return this.props.honeypot_image.styles[this.props.style];
  }
};
