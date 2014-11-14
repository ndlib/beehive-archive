/** @jsx React.DOM */

var converter = new Showdown.converter();

var Item = React.createClass({
  render: function() {
    //var rawMarkup = converter.makeHtml(this.props.children.toString());
    return (
      <li>
        {this.props.title}
        <img src={this.props.src } width="100" />
      </li>
    );
  }
});

var ItemList = React.createClass({
  render: function() {
    var itemNodes = this.props.data.map(function(item, index) {
      return (
        <Item title={item.title} key={item.id} src={item.links.tiled_image.uri} />
      );
    });
    return (
      <ul>
        {itemNodes}
      </ul>
    );
  }
});

var AddItemBox = React.createClass({
  loadItemsFromServer: function() {
    $.ajax({
      url: 'http://localhost:3017/collections/1/items.json?include=tiled_images',
      dataType: 'json',
      success: function(data) {
        console.log(data)
        this.setState({data: data.items});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
    this.loadItemsFromServer();
    setInterval(this.loadItemsFromServer(), 8000);
  },
  render: function() {
    console.log("render")
    console.log(this.state)
    return (
      <div>
        <h1>Items to Add!!</h1>
        <ItemList data={this.state.data} />
      </div>
    );
  }
});


$(document).on("page:change", function() {
  var $content = $("#content");
  return
  if ($content.length > 0) {
    React.render(
      <AddItemBox />,
      document.getElementById('content')
    );
  }
})
