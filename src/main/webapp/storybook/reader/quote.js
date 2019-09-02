class Quote {
  static get toolbox() {
    if (!$(".characterSelectDialog").get(0)) {
      let dialog = document.createElement("span");
      $(dialog).css("display", "none");
      $(dialog).addClass("characterSelectDialog");
      $(dialog).html("<div><select class='characterSelectDialogOptionList'></select><br/><br/></div>");
      $(document.body).append($(dialog));

    }
    return {
      title: 'Quote',
      icon: '<img src="icons8-add-to-favorites-32.png" width="17px" />'
    };
  }

  constructor({data}){
    this.data=data;
  }

  render() {
    let self = this;
    this.character = this.data.character;
    this.container = document.createElement("div");
    let container = this.container;
    $(container).html("<table border='1' style='width: 100%'><tr><td class='character' style='width: 120px'>123</td><td class='quote'>123</td></tr></table>");
    $(container).find(".character").html(this.data?this.data.character:"");
    $(container).find(".quote").html("<input type='text' class='quoteMessage' style='width: 100%' value=''/>");
    if(this.data){
      $($(container).find(".quoteMessage").get(0)).val(this.data.message);
    }
    $(container).find(".character").click(function () {
      self.switch2CharacterSelect();
    });
    return container;
  }

  async switch2CharacterSelect() {
    let self=this;
    let dialog = $(".characterSelectDialog").get(0);
    let select = $(dialog).find("select").get(0);
    $(select).empty();
    let characters = await this.getCharacterList();
    for (let character of characters) {
      let option = document.createElement("option");
      $(option).attr("value", character);
      $(option).text(character);
      $(select).append($(option));
    }
    $(select).val(this.character);
    $(dialog).dialog({
      modal: true,
      buttons: [{
        text: "Ok",
        icon: "ui-icon-check",
        click: function () {
          self.character=$(select).val();
          self.switch2CharacterDisplay();
          $(this).dialog("close");
        }
      },
      {
        text: "Cancel",
        icon: "ui-icon-close",
        click: function () {
          $(this).dialog("close");
        }
      }]
    });
  }

  async getCharacterList() {
    return ["test1", "test2", "test3"];
  }

  switch2CharacterDisplay() {
    let container = $(this.container).find(".character").get(0);
    $(container).empty();
    $(container).html(this.character);
  }

  save(blockContent) {
    return {
      character: this.character,
      message: $($(blockContent).find(".quoteMessage").get(0)).val()
    }
  }
}