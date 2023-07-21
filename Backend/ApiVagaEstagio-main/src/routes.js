import {Router} from 'express';

import TaskController from './controllers/TaskController';



//Rotas
const routes = new Router();
//GET
routes.get('/getLembretesAtivos', TaskController.index);
//POST
routes.post('/criarLembrete', TaskController.store);
//PUT
routes.put('/updateLembrete/:lembrete_id', TaskController.update);
//DELETE
routes.delete('/deleteLembrete/:lembrete_id',TaskController.destroy);



module.exports = routes;