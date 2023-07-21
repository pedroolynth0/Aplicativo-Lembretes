import {Schema, model} from 'mongoose';


//Estrutura lembretes
const LembreteSchema = new Schema({
    nome: String,
    descricao: String,
    data: Date,
    status: Boolean
});

export default model('Lembrete',LembreteSchema);