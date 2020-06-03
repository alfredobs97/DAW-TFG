import { UserDto } from "./user.dto"

export class UserLoginDto extends UserDto{
    username: string;
    pass: string;
}