export class UserDto {
    username: string;
    name: string;
    pass: string;
    tel: number;
    isAdmin: boolean = false;

  constructor(user: any) {
    const { username, name, pass, tel, isAdmin } = user;
    this.username = username;
    this.name = name;
    this.pass = pass;
    this.tel = tel;
    this.isAdmin = isAdmin;
  }
}