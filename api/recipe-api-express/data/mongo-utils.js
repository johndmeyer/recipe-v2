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
    let recordsets = [];
    let collectionName = getCollectionName(params);

    try {
        await client.connect();

        const db = client.db('documents');

        const collection = db.collection(collectionName);

        const query = buildQuery(collection, params);

        recordsets.push(await query.toArray());
    } catch(ex) {        
        console.log(ex); // TODO: implement error handling
    } finally {
        await client.close();
    }

    // Moves id to object level - helps with inflating flat heirarchies in the logic layer
    recordsets = restructureData(recordsets, collectionName)

    return recordsets;
}

function restructureData(recordsets, collectionName) {
    const newRecordsets = [];

    for(const recordset of recordsets) {
        const newRecordset = [];

        for (const record of recordset) {
            const id = record._id.toString();

            delete record._id;

            record[`${collectionName}Id`] = id;

            if (record[`${collectionName}IdParent`] === undefined) {
                record[`${collectionName}IdParent`] = null;
            }            

            newRecordset.push(record);
        }

        newRecordsets.push(newRecordset);
    }

    return newRecordsets;
}

function getCollectionName(params) {
    if (params.procName.includes('Equipment')) {
        return 'equipment';
    }
    if (params.procName.includes('Ingredient')) {
        return 'ingredient';
    }
    if (params.procName.includes('Tag')) {
        return 'tag';
    }
    if (params.procName.includes('Recipe')) {
        return 'recipe';
    }
    if (params.procName.includes('Unit')) {
        return 'unit';
    }
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
            query = collection.find();
            break;
        case 'retrieveIngredients':
            query = collection.find();
            break;
        case 'retrieveRecipe':
        case 'retrieveRecipes':
            query = collection.find(args);
            break;
        case 'retrieveTags':
            query = collection.find();
            break;
        case 'retrieveUnits':
            query = collection.find({ $or: [{unitType: 'Natural'}, { unitType: params.procArgs[0].value }] });
            break;
    }

    return query;
}

module.exports = mongoData;