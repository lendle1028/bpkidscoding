/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class StoryMetaJS {
    constructor(root) {
        this.rootURL = root + "/webapi";
    }

    static get ALL() {
        return 0;
    }

    static get BY_ID() {
        return -1;
    }

    static get BY_AUTHOR() {
        return 1;
    }

    static get BY_KEYWORD() {
        return 2;
    }

    count() {
        return this.query(this.rootURL + "/meta/count");
    }

    /**
     * a portal method for all find methods
     * @param {*} type must be one of ALL, BY_ID, BY_AUTHOR, BY_KEYWORD
     * @param {*} arg 
     * @param {*} pageSize 
     * @param {*} pageIndex 
     */
    find(type, arg = null, pageSize = 100, pageIndex = 0) {
        switch (type) {
            case StoryMetaJS.ALL:
                return this.findAll(pageSize, pageIndex);
            case StoryMetaJS.BY_ID:
                return this.findById(arg);
            case StoryMetaJS.BY_AUTHOR:
                return this.findByAuthor(arg, pageSize, pageIndex);
            case StoryMetaJS.BY_KEYWORD:
                return this.findByKeywords(arg, pageSize, pageIndex);
        }
        return null;
    }

    findAll(pageSize = 100, pageIndex = 0) {
        return this.query(this.rootURL + "/meta?pageSize=" + pageSize + "&pageIndex=" + pageIndex);
    }

    findById(id) {
        return this.query(this.rootURL + "/meta/" + id + "?pageSize=" + pageSize + "&pageIndex=" + pageIndex);
    }

    findByAuthor(author, pageSize = 100, pageIndex = 0) {
        return this.query(this.rootURL + "/meta/author/" + author + "?pageSize=" + pageSize + "&pageIndex=" + pageIndex);
    }

    findByKeywords(keyword, pageSize = 100, pageIndex = 0) {
        return this.query(this.rootURL + "/meta/keyword/" + keyword + "?pageSize=" + pageSize + "&pageIndex=" + pageIndex);
    }

    query(url) {
        let p = new Promise((resolve, reject) => {
            $.ajax(url, {
                contentType: "application/json",
                success: function (data) {
                    resolve(data);
                },
                error: function (xhr) {
                    reject(xhr);
                }
            });
        });
        return p;
    }
}

