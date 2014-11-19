
var SlideForm = React.createClass({
  success: function () {
    React.render(<Sections />, $('#slide_form').get(0))
  },
  handleSectionSubmit: function(section) {

    this.setState({data: section}, function() {
      // `setState` accepts a callback. To avoid (improbable) race condition,
      // `we'll send the ajax request right after we optimistically set the new
      // `state.
      $.ajax({
        url: 'sections.json',
        dataType: 'json',
        type: 'POST',
        data: { section: section },
        success: function(data) {
          this.success();
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
    });
  },
  componentDidMount: function (){
    $('#sectionDescription').redactor({});
  },
  handleSubmit: function(e) {
    e.preventDefault();

    var title = this.refs.title.getDOMNode().value.trim();
    var description = this.refs.description.getDOMNode().value.trim();
    var image = this.refs.image.getDOMNode().value.trim();
    var item_id = this.refs.item_id.getDOMNode().value.trim();

    if (!title) {
      return;
    }

    this.handleSectionSubmit({title: title, description: description, image: image, item_id: item_id});
    this.refs.title.getDOMNode().value = '';
    this.refs.description.getDOMNode().value = '';
    return;
  },
  render: function() {
    return (
      <div>
      <h1>New Section</h1>
      <form className="slideForm" onSubmit={this.handleSubmit}>
        <div className="form-group">
          <label className="control-label" forName="titleInput">Title</label>
          <input type="text" id="titleInput" className="form-control" placeholder="Your name" ref="title" defaultValue={this.props.item.title} />
        </div>
        <div className="row">
          <div className="col-md-6">
            <img src={this.props.item.links.tiled_image.uri} width="100%" />
          </div>
          <div className="col-md-6">
            <div className="form-group">
              <label className="control-label" forName="sectionDescription">Description</label>
              <textarea className="form-control" id="sectionDescription" rows="3" placeholder="Say something..." ref="description" />
            </div>
          </div>
        </div>
        <input type="hidden" ref="item_id" value={this.props.item.id} />
        <input type="hidden" ref="image" value={this.props.item.links.tiled_image.uri} />
        <div className="form-group">
          <button className="btn btn-primary">Save</button>
        </div>
      </form>
      </div>
    );
  }
});

var SectionList = React.createClass({
  render: function() {
    var onClickFunction = this.props.onSectionClick
    var rows = [];
    for (var i=0; i < this.props.data.length; i++) {
      section = this.props.data[i]
      rows.push(<Section section={section} key={section.id} onSectionClick={onClickFunction} />);
      rows.push(<SectionSpacer />);
    }

    return (
      <div>
        {rows}
      </div>
    );
  }
});


var Section = React.createClass({
  handleClick: function (e) {
    e.preventDefault();
    this.props.onItemClick(this.props.section)
  },
  render: function() {
    //var rawMarkup = converter.makeHtml(this.props.children.toString());
    return (
      <div className="section_display">
        <a href="#" onClick={this.handleClick}>
          <img src={this.props.section.image } width="300" />
        </a>
      </div>
    );
  }
});

var SectionSpacer = React.createClass({

  render: function() {
    return (
      <div className="section_spacer"></div>
    )
  }
});

var Sections = React.createClass({
  loadSectionsFromServer: function() {
    $.ajax({
      url: 'sections.json',
      dataType: 'json',
      success: function(data) {
        this.setState({data: data.sections});
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
    this.loadSectionsFromServer();
    setInterval(this.loadSectionsFromServer(), 8000);
  },
  sectionClick: function() {

  },
  render: function() {
    return (
      <div>
        <h1>Sections</h1>
        <SectionList data={this.state.data} onSectionClick={this.sectionClick} />
      </div>
    );
  }
});


