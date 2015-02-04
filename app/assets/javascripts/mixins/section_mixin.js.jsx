var SectionMixin = {
  getInitialState: function() {
    return {
      sections: [],
      section: {}
    };
  },
  loadSection: function(url) {
    this.get(url, this.saveSection);
  },
  loadSections: function(url) {
    this.get(url, this.saveSections);
  },
  createSection: function(attributes) {

  },
  saveSection: function(data) {
    this.setState({section: data.section })
  },
  saveSections: function(data) {
    this.setState({sections: data.sections })
  }
}
