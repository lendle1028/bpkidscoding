class Separator {
  static get toolbox() {
    return {
      title: 'Separator',
      icon: '<img src="icons8-double-tick-32.png" width="17px" />'
    };
  }

  render() {
    this.container = document.createElement("hr");
    $(this.container).addClass("separator");
    return this.container;
  }

  

  save(blockContent) {
    return {
     
    }
  }
}