import express from 'express'
import mongoose from 'mongoose';
import routes from './routes';


class App{
    constructor(){
        this.server = express();

        mongoose.connect('mongodb+srv://root:olyntho09@databaselembretes.nrml78g.mongodb.net/databaseLembretes?retryWrites=true&w=majority', {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        })

        this.middlewares();
        this.routes();
    }

    middlewares(){
        this.server.use(express.json());
    }
    routes(){
        this.server.use(routes);
    }
}

module.exports = new App().server;