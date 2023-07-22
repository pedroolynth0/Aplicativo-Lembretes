import Lembrete from "../models/Lembrete";
import {format} from "date-fns";
// metodos index, show, update, store, destroy

/*
index: Listar todas as tarefas
store : Criar uma nova tarefa
show: Mostrar apenas uma tarefa
update: Alterar alguma tarefa
destroy: deletar alguma tarefa
*/


class TaskController{
    
    async index(req, res) {
        const { status } = req.query;
    
        // Encontre os lembretes ativos
        const lembretes = await Lembrete.find({ status });
    
        // Verifique se o array não é vazio antes de ordenar e formatar a data
        const lembretesFormatados = lembretes && lembretes.length > 0
          ? lembretes
              .sort((a, b) => (a.data > b.data ? 1 : -1))
              .map((lembrete) => ({
                ...lembrete.toJSON(),
                data: format(new Date(lembrete.data), 'dd/MM/yyyy HH:mm'),
              }))
          : [];
    
        return res.json(lembretesFormatados);
      }

    //Salvar lembrete no banco de dados
    async store(req,res){
        const {nome,descricao,data,status} = req.body;

        const formatarData = format(new Date(data), 'yyyy-MM-dd HH:mm');
        const lembrete = await Lembrete.create({
            nome,
            descricao,
            data: formatarData,
            status
        })
        
        return res.json({
            lembrete
        })
    }
    //Alterar lembrete no banco de dados
    async update(req,res){
        const {lembrete_id} = req.params;
        const {nome,descricao,data,status} = req.body;
        const formatarData = format(new Date(data), 'yyyy-MM-dd HH:mm');
        const lembrete = await Lembrete.updateOne({_id:lembrete_id},
            {
            nome,
            descricao,
            data: formatarData,
            status
            })


        return res.send();
    }

    //Deletar lembrete no banco de dados
    async destroy(req,res){
        const {lembrete_id} = req.params;

        await Lembrete.findByIdAndDelete({_id: lembrete_id})

        return res.json({message :"Excluido com sucesso"})
    }
}

export default new TaskController();