export default {
  type: 'object',
  required: ['NODE_ENV'],
  // required: ['NODE_ENV', 'DB_HOST', 'DB_PORT', 'DB_USER', 'DB_PASSWORD', 'DB_NAME'],
  properties: {
    NODE_ENV: {
      type: 'string',
      default: 'production'
    },
    DB_HOST: {
      type: 'string',
    },
    DB_PORT: {
      type: 'string',
    },
    DB_USER: {
      type: 'string',
    },
    DB_PASSWORD: {
      type: 'string',
    },
    DB_NAME: {
      type: 'string',
    }
  }
}
