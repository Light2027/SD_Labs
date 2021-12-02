const server = require('./index');

const chai = require('chai');
const chaiHttp = require('chai-http');
const should = chai.should();

chai.use(chaiHttp);

describe('/GET Hello World!', () => {
    it('It should get back a "Hello World!" string.', (done) => {
        chai.request(server)
        .get('/')
        .end((_, result) => {
            result.should.have.status(200);
            result.text.should.be.a('string');
            result.text.should.eql("Hello World!");
            done();
        });
    });
});