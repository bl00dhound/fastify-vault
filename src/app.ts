import { FastifyInstance } from 'fastify'
import Sensible from '@fastify/sensible'
import Env from '@fastify/env'
import Cors from '@fastify/cors'
import KnexPlugin from 'fastify-knexjs'

import HealthRouter from './routes/health';
import { EnvConfig } from './schemas';

declare module 'fastify' {
  interface FastifyInstance {
    config: {
      NODE_ENV: string;
      DB_HOST: string;
      DB_PORT: string;
      DB_USER: string;
      DB_PASSWORD: string;
      DB_NAME: string;
    },
    knex: any
  }
}

export default async (fastify: FastifyInstance, opts) => {
  await fastify.register(Env, {
    schema: EnvConfig
  })

  fastify.register(Sensible)

  fastify.register(Cors, {
    origin: false
  })

  fastify.register(KnexPlugin, {
    client: 'pg',
    connection: {
      host: fastify.config.DB_HOST,
      port: fastify.config.DB_PORT,
      user: fastify.config.DB_USER,
      password: fastify.config.DB_PASSWORD,
      database: fastify.config.DB_NAME
    }
  })

  fastify.register(HealthRouter, { prefix: '/api/health' })
}
