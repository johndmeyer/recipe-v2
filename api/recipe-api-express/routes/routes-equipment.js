'use strict';

const express = require('express');

const logicCreateEquipment = require('../logic/equipment/logic-create-equipment');
const logicRetrieveEquipments = require('../logic/equipment/logic-retrieve-equipments');
const logicUpdateEquipment = require('../logic/equipment/logic-update-equipment');

const router = express.Router();

/**
 * DELETE /equipment/{id}
 * @summary Deletes an equipment table entry and all entries in the recipe-equipment table for a given equipmentId
 * @tags Equipment
 * @param {integer} equipmentId.path.required
 * @return {object} 200 - Success response
*/
router.delete('/:equipmentId', async (req, res, next) => {
    try {
        res.send('Sorry not yet implemented')
    } catch (err) {
        next(err);
    } 
});

/**
 * GET /equipment/{equipmentId}
 * @summary Retrieves a hierarchical list of equipment - used for drop down
 * @tags Equipment
 * @param {integer} ingredientId.path - IngredientId brings back a single ingredient if passed, if ommited returns a hierarchical list of  all equipment
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *   data: {
 *     equipment: [
 *       {
 *         equipmentId: 30,
 *         equipmentName: '30 minutes or less',
 *         equipmentParentId: 5
 *       }
 *     ]
 *   }  
 * }
*/
router.get('/:ingredientId', async (req, res, next) => {
    try {
        res.send(await logicRetrieveEquipments())
    } catch (err) {
        next(err);
    }    
});

/**
 * POST /equipment
 * @summary Changes the name and/or description of an equipment table entry
 * @tags Equipment
 * @param {object} request.body.required
 * @return {object} 200 - Success response
 * @example request - example payload
 * {
 *   equipmentId: 5,
 *   equipmentName: 'Equipment name here'
 *   equipmentDescription: 'Equipment description here'   
 * }
*/
router.post('/:equipmentId/:equipmentName', async(req, res, next) => {
    try {
        const equipmentDescription = req.body.equipmentDescription; // TODO: handle bad input
        const equipmentId = req.body.equipmentId; // TODO: handle bad input
        const equipmentName = req.body.equipmentName; // TODO: handle bad input
        
        res.send(await logicUpdateEquipment({ equipmentDescription, equipmentId, equipmentName }));
    } catch (err) {
        next(err);
    }
});

/**
 * PUT /equipment
 * @summary Creates a new equipment table entry
 * @tags Equipment
 * @param {object} request.body.required
 * @return {object} 200 - Success response
 * @example request - example payload
 * {
 *   equipmentParentId: 5,
 *   equipmentName: 'Equipment name here'
 *   equipmentDescription: 'Equipment description here'      
 * }
 * @example response - 200 - example success response
 * {
 *   data: {
 *     equipment: [
 *       {
 *         equipmentId: 30,
 *         equipmentName: '30 minutes or less',
 *         equipmentParentId: 5
 *       }
 *     ]
 *   } 
 * }
*/
router.put('/:equipmentParentId/:equipmentName', async(req, res, next) => {
    try {
        const equipmentDescription = req.body.equipmentDescription; // TODO: handle bad input
        const equipmentParentId = req.params.equipmentParentId; // TODO: handle bad input
        const equipmentName = req.params.equipmentName; // TODO: handle bad input

        res.send(await logicCreateEquipment({ equipmentDescription, equipmentParentId, equipmentName }))
    } catch (err) {
        next(err);
    }
});

module.exports = router;