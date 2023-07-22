// TaskController.test.js

import TaskController from "../src/controllers/TaskController";
import Lembrete from "../src/models/Lembrete";



//banco de dados de teste
const mockLembretes = [
    {
      _id: "1",
      nome: "Lembrete 1",
      descricao: "Descrição do Lembrete 1",
      data: "2023-07-25 05:00",
      status: "ativo",
    },
    {
      _id: "2",
      nome: "Lembrete 2",
      descricao: "Descrição do Lembrete 2",
      data: "2023-07-25 05:00",
      status: "ativo",
    },
  ];  



// Mock - Simular os mesmos comportamentos de um banco de dados
jest.mock("../src/models/Lembrete", () => ({

    // Certificar que o mock retorna os dados corretamente
    find: jest.fn().mockResolvedValue(mockLembretes), 
    create: jest.fn().mockImplementation((lembrete) => {
      // Simular a criação de um novo lembrete com um ID único
      const novoLembrete = { ...lembrete, _id: "3" };
      mockLembretes.push(novoLembrete);
      return novoLembrete;
    }),
    updateOne: jest.fn().mockResolvedValue({}),
    findByIdAndDelete: jest.fn().mockResolvedValue({}),
  }));
  

describe("TaskController", () => {
  afterEach(() => {
    jest.clearAllMocks();
  });


  //Get
  describe("index", () => {
    it("deve listar todos os lembretes ativos ordenados pela data", async () => {
      const req = { query: { status: "ativo" } };
      const res = {
        json: jest.fn(), 
      };

      await TaskController.index(req, res);

      expect(Lembrete.find).toHaveBeenCalledWith({ status: "ativo" });
      expect(res.json).toHaveBeenCalledWith(expect.any(Array)); 
    });
  });

  //Post
  describe("store", () => {
    it("deve criar um novo lembrete no banco de dados", async () => {
      const req = {
        body: {
          nome: "Novo Lembrete",
          descricao: "Descrição do Novo Lembrete",
          data: "2023-07-25 05:00",
          status: "ativo",
        },
      };
      const res = {
        json: jest.fn().mockReturnThis(),
      };
  
      await TaskController.store(req, res);
  
      expect(Lembrete.create).toHaveBeenCalledWith({
        nome: "Novo Lembrete",
        descricao: "Descrição do Novo Lembrete",
        data: "2023-07-25 05:00",
        status: "ativo",
      });
      expect(res.json).toHaveBeenCalledWith({
        lembrete: expect.objectContaining({
          nome: "Novo Lembrete",
          descricao: "Descrição do Novo Lembrete",
          data: "2023-07-25 05:00",
          status: "ativo",
        }),
      });
    });
  });
  

  //PUT
  describe("update", () => {
    it("deve atualizar um lembrete existente no banco de dados", async () => {
      const req = {
        params: { lembrete_id: "1" },
        body: {
          nome: "Lembrete Atualizado",
          descricao: "Descrição do Lembrete Atualizado",
          data: "2023-07-25 05:00",
          status: "concluido",
        },
      };
      const res = { send: jest.fn().mockReturnThis() };

      await TaskController.update(req, res);

      expect(Lembrete.updateOne).toHaveBeenCalledWith(
        { _id: "1" },
        {
          nome: "Lembrete Atualizado",
          descricao: "Descrição do Lembrete Atualizado",
          data: "2023-07-25 05:00",
          status: "concluido",
        }
      );
      expect(res.send).toHaveBeenCalled();
    });
  });


  //Delete
  describe("destroy", () => {
    it("deve deletar um lembrete do banco de dados", async () => {
      const req = { params: { lembrete_id: "1" } };
      const res = {
        json: jest.fn().mockReturnThis(),
      };

      await TaskController.destroy(req, res);

      expect(Lembrete.findByIdAndDelete).toHaveBeenCalledWith({
        _id: "1",
      });
      expect(res.json).toHaveBeenCalledWith({
        message: "Excluido com sucesso",
      });
    });
  });
});
