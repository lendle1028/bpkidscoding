class EditorDataProcessor{
    /**
     * check the blocks portion of the two data instance and check whether they
     * are the same or not
     * @param {*} data1 
     * @param {*} data2 
     */
    static isModified(data1, data2){
        if(data1.blocks.length!=data2.blocks.length){
            return true;
        }
        for(let i=0; i<data1.blocks.length; i++){
            for(let key in data1.blocks[i].data){
                if(data1.blocks[i].data[key]!=data2.blocks[i].data[key]){
                    return true;
                }
            }
            for(let key in data2.blocks[i].data){
                if(data1.blocks[i].data[key]!=data2.blocks[i].data[key]){
                    return true;
                }
            }
        }
        return false;
    }
} 