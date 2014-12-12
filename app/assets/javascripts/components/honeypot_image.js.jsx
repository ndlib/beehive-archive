/** @jsx React.DOM */

var HoneypotImage = React.createClass({
  propTypes: {
    honeypot_image: React.PropTypes.object.isRequired,
    style: React.PropTypes.string,
  },
  getDefaultProps: function() {
    return {
      style: 'original'
    };
  },
  host: function () {
    return "localhost:3019";
  },
  path: function () {
    var style_object = this.props.honeypot_image.styles[this.props.style]

    return "/images/" + style_object.path
  },
  uri: function() {
    return "http://" + this.host() + this.path();
  },
  render: function() {
    return (<img src={this.uri()} />)
  }
})
