/** @jsx React.DOM */

var converter = new Showdown.converter();

var Item = React.createClass({
  handleClick: function (e) {
    e.preventDefault();
    this.props.onItemClick(this.props.item)
  },
  render: function() {
    //var rawMarkup = converter.makeHtml(this.props.children.toString());
    return (
      <li>
        <a href="#" onClick={this.handleClick}>
          {this.props.item.title}
          <img src={this.props.item.links.tiled_image.uri } width="100" />
        </a>
      </li>
    );
  }
});

var ItemList = React.createClass({
  render: function() {
    var onClickFunction = this.props.onItemClick
    var itemNodes = this.props.data.map(function(item, index) {
      return (
        <Item item={item} key={item.id} onItemClick={onClickFunction} />
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
  itemClick: function(item) {
    React.render(<SlideForm item={item} key={item.id} />, $('#slide_form').get(0) )
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
        <ItemList data={this.state.data} onItemClick={this.itemClick} />
      </div>
    );
  }
});

