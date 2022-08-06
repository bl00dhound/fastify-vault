import { FastifyInstance } from 'fastify';

export default async (fastify: FastifyInstance, opts) => {
  fastify.get('/liveness', async (request, reply) => ({ msg: 'OK' }))


  fastify.get('/readiness', async (request, reply) => {
    try {
      await fastify.knex.select('*').from('example')
      return { msg: 'OK' }
    } catch (e) {
      fastify.log.error(e)
      return reply.internalServerError()
    }
  })
}