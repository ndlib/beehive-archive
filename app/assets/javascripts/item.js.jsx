/** @jsx React.DOM */

var converter = new Showdown.converter();

var Item = React.createClass({
  handleClick: function (e) {
    e.preventDefault();
    React.render(<SlideForm item={this.props.item} key={this.props.item.id} />, $('#slide_form').get(0) )

  },
  render: function() {
    //var rawMarkup = converter.makeHtml(this.props.children.toString());
    return (
      <li>
        <a href="#" onClick={this.handleClick}>{this.props.item.title}</a>
        <img src={this.props.item.links.tiled_image.uri } width="100" />
      </li>
    );
  }
});

var ItemList = React.createClass({
  render: function() {
    var itemNodes = this.props.data.map(function(item, index) {
      return (
        <Item item={item} key={item.id} />
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
    return (
      <div>
        <h1>Items to Add!!</h1>
        <ItemList data={this.state.data} />
      </div>
    );
  }
});

