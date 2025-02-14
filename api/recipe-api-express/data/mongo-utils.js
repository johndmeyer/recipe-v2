const { MongoClient } = require('mongodb');

const url = 'mongodb://127.0.0.1:27017'; // TODO: put this in an env variable

const client = new MongoClient(url);

/**
 * Gets data from mongodb. This implementation is pretty sloppy programming but it does go to show how 
 * quickly you can get something up and running with it.
 * @param {object} params An object containing the name and arguments needed to obtain the data
 * @param {string} params.procName The name of the stored procedure to be called
 * @param {array} [params.procArgs] An array of objects containing the name, type, and value of each argument
 * @returns {Promise} Returns a promise that resolves to the data
 */
async function mongoData(params) {
    const recordsets = [];

    try {
        await client.connect();

        const db = client.db('recipe');

        const collection = db.collection('documents');

        const query = buildQuery(collection, params);

        recordsets.push(await query.toArray());
    } catch(ex) {        
        console.log(ex); // TODO: implement error handling
    } finally {
        await client.close();
    }

    return recordsets;
}

function buildQuery(collection, params) {
    const args = {};
    
    if (params.procArgs){
        for(const arg of params.procArgs) {
            if(arg.value != undefined && arg.value != '' && arg.value != 0) {
                args[arg.name] = arg.value;
            }
        }
    }

    switch(params.procName) {
        case 'retrieveEquipments':
            query = collection.aggregate([{$unwind: '$equipments'}, {$group: {_id: '$equipments.name'}}]);
            break;
        case 'retrieveIngredients':
            query = collection.aggregate([{$unwind: '$ingredients'}, {$group: {_id: '$ingredients.name'}}]);
            break;
        case 'retrieveRecipe':
        case 'retrieveRecipes':
            query = collection.find(args);
            break;
        case 'retrieveTags':
            query = collection.aggregate([{$unwind: '$tags'}, {$group: {_id: '$tags.name'}}]);
            break;
        case 'retrieveUnits':
            query = collection.aggregate([{$unwind: '$units'}, {$group: {_id: '$units.name'}}]);
            break;
    }

    return query;
}

module.exports = mongoData;