
var SlideForm = React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();
    var author = this.refs.author.getDOMNode().value.trim();
    var text = this.refs.text.getDOMNode().value.trim();
    if (!text || !author) {
      return;
    }
    this.props.onCommentSubmit({author: author, text: text});
    this.refs.author.getDOMNode().value = '';
    this.refs.text.getDOMNode().value = '';
    return;
  },
  render: function() {
    return (
      <form className="slideForm" onSubmit={this.handleSubmit}>
        <div className="form-group">
          <label className="control-label" forName="titleInput">Title</label>
          <input type="text" id="titleInput" name="slide[title]" className="form-control" placeholder="Your name" ref="title" defaultValue={this.props.item.title} />
        </div>
        <div className="row">
          <div className="col-md-6">
            <img src={this.props.item.links.tiled_image.uri} width="100%" />
          </div>
          <div className="col-md-6">
            <div className="form-group">
              <label className="control-label" forName="commentDescription">Description</label>
              <textarea className="form-control" id="commentDescription" rows="3" placeholder="Say something..." ref="description" name="slide[description]" />
            </div>
          </div>
        </div>
        <div className="form-group">
          <button className="btn btn-primary">Save</button>
        </div>
      </form>
    );
  }
});
