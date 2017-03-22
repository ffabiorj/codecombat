c = require './../schemas'

ClassroomSchema = c.object {title: 'Classroom', required: ['name']}
c.extendNamedProperties ClassroomSchema  # name first

_.extend ClassroomSchema.properties,
  name: { type: 'string', minLength: 1 }
  members: c.array {title: 'Members'}, c.objectId()
  deletedMembers: c.array {title: 'Deleted Members'}, c.objectId()
  ownerID: c.objectId()
  description: {type: 'string'}
  code: c.shortString(title: "Unique code to redeem")
  codeCamel: c.shortString(title: "UpperCamelCase version of code for display purposes")
  aceConfig:
    language: {type: 'string', 'enum': ['python', 'javascript']}
  averageStudentExp: { type: 'string' }
  ageRangeMin: { type: 'string' }
  ageRangeMax: { type: 'string' }
  archived:
    type: 'boolean'
    default: false
    description: 'Visual only; determines if the classroom is in the "archived" list of the normal list.'
  courses: c.array { title: 'Courses' }, c.object { title: 'Course' }, {
    _id: c.objectId()
    levels: c.array { title: 'Levels' }, c.object { title: 'Level' }, {
      practice: {type: 'boolean'}
      practiceThresholdMinutes: {type: 'number'}
      primerLanguage: { type: 'string', enum: ['javascript', 'python'] }
      shareable: { title: 'Shareable', type: ['string', 'boolean'], enum: [false, true, 'project'], description: 'Whether the level is not shareable, shareable, or a sharing-encouraged project level.' }
      type: c.shortString()
      original: c.objectId()
      name: {type: 'string'}
      slug: {type: 'string'}
    }
  }
  settings: c.object {title: 'Classroom Settings', required: []}, {
    optionsEditable: { type: 'boolean', description: 'Allow teacher to use these settings.', default: false }
    map: { type: 'boolean', description: 'Classroom map.', default: false }
    jumpRightIn: { type: 'boolean', description: 'Skip map when stating the day.', default: true }
    backToMap: { type: 'boolean', description: 'Go back to the map after victory.', default: false }
    gems: {type: 'boolean', description: 'Allow students to earn gems.', default: false}
    xp: {type: 'boolean', description: 'Students collect XP and level up.', default: false}
    #rob: {type: 'number', description: 'Test'}
  }
   

c.extendBasicProperties ClassroomSchema, 'Classroom'
ClassroomSchema.properties.settings.additionalProperties = true

module.exports = ClassroomSchema
