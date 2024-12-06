'use strict';

const express = require('express');

const logicCreateEquipment = require('../logic/equipment/logic-create-equipment');
const logicRetrieveEquipments = require('../logic/equipment/logic-retrieve-equipments');
const logicUpdateEquipment = require('../logic/equipment/logic-update-equipment');

const router = express.Router();

router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveEquipments())
    } catch (err) {
        next(err);
    }    
});

router.post('/:equipmentId/:equipmentName', async(req, res, next) => {
    try {
        const equipmentDescription = req.body.equipmentDescription; // TODO: handle bad input
        const equipmentId = req.params.equipmentId; // TODO: handle bad input
        const equipmentName = req.params.equipmentName; // TODO: handle bad input
        
        res.send(await logicUpdateEquipment({ equipmentDescription, equipmentId, equipmentName }));
    } catch (err) {
        next(err);
    }
});

router.put('/:equipmentId/:equipmentName', async(req, res, next) => {
    try {
        const equipmentDescription = req.body.equipmentDescription; // TODO: handle bad input
        const equipmentId = req.params.equipmentId; // TODO: handle bad input
        const equipmentName = req.params.equipmentName; // TODO: handle bad input

        res.send(await logicCreateEquipment({ equipmentDescription, equipmentId, equipmentName }))
    } catch (err) {
        next(err);
    }
});

module.exports = router;