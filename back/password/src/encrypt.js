const bcrypt = require('bcrypt');
const saltRounds = 10;


function encryptPass(passPlain){
    return bcrypt.hash(passPlain, saltRounds);
}

function decryptPass(passPlain, passEncryt){
    return bcrypt.compare(passPlain, passEncryt);
}

exports.encryptPass = encryptPass;
exports.decryptPass = decryptPass;


