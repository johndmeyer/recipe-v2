'use strict';

function buildJsonTree(data, dataName, parentId = null) {
    const result = [];
  
    for (const item of data) {
        if (item[`${dataName}IdParent`] === parentId) {
            const items = buildJsonTree(data, dataName, item[`${dataName}Id`]);
            const node = { ...item, items };

            if (items.length > 0) {
                node.items = items;
            }

            result.push(node);
        }
    }
  
    return result;
}

module.exports = buildJsonTree;
