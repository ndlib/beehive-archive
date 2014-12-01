
var TiledImage = React.createClass({
  propTypes: {
    tiled_image: React.PropTypes.object.isRequired,
  },
  host: function () {
    return "localhost:3017";
  },
  path: function () {
    var split_path = this.props.tiled_image.path.split('/');
    var filename = split_path.pop();
    var id = split_path.pop();

    return "/system/items/images/000/000/" + id + "/original/" + filename;
  },
  uri: function() {
    return "http://" + this.host() + this.path();
  },
  render: function() {
    return (<img src={this.uri()} />)
  }
})
