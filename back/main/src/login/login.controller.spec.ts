import { Test, TestingModule } from '@nestjs/testing';
import { LoginController } from './login.controller';

describe('Prueba Controller', () => {
  let controller: LoginController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [LoginController],
    }).compile();

    controller = module.get<LoginController>(LoginController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should create User', () => {
    expect(controller).toBeDefined();
  });
});
