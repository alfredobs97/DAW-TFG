import { MigrationInterface, QueryRunner, getRepository } from 'typeorm';
import { HttpService, BadGatewayException } from '@nestjs/common';
import { User } from '../login/user.entity';

export class users1585417531412 implements MigrationInterface {
  httpService = new HttpService();

  public async up(queryRunner: QueryRunner): Promise<any> {
    const plainPass = 'flutterMola';
    const response = await this.httpService
      .post(process.env.PASSWORD_BACKEND_ENCRYPT, { pass: plainPass })
      .toPromise();

    if (response.status !== 200) {
      //TODO rethink statusCode
      throw new BadGatewayException();
    }

    await getRepository(User).save([
      {
        username: 'flutterista',
        name: 'admin',
        tel: 0,
        isAdmin: true,
        pass: response.data,
      },
    ]);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {}
}
