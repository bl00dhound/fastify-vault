import { FastifyInstance } from 'fastify';

export default async (fastify: FastifyInstance, opts) => {
  fastify.get('/liveness', async (request, reply) => ({ msg: 'OK' }))


  fastify.get('/readiness', async (request, reply) => {
    try {
      await fastify.knex.select('1').from('people')
      return { msg: 'OK' }
    } catch (e) {
      return reply.internalServerError()
    }
  })
}