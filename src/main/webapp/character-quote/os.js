class Os {
  static get toolbox() {
    return {
      title: 'Os',
      icon: '<img src="icons8-php-designer-32.png" width="17px" />'
    };
  }

  constructor({data}){
    this.data=data;
  }

  render() {
    this.container = document.createElement("textarea");
    $(this.container).attr("rows", "10");
    $(this.container).addClass("os");
    if(this.data){
      $(this.container).val(this.data.message);
    }
    return this.container;
  }

  save(blockContent) {
    return {
      message: $(blockContent).val()
    }
  }
}