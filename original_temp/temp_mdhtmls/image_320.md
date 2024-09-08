Here's an example code for a Discord bot using Discord.js v14 that has a ban command:
```javascript
const { Client, Intents, Collection } = require('discord.js');
const { token } = require('./config.json');

const client = new Client({ intents: [Intents.FLAGS.GUILDS, Intents.FLAGS.GUILD_MESSAGES] });

client.commands = new Collection();

const commandFiles = fs.readdirSync('./commands').filter(file => file.endsWith('.js'));

for (const file of commandFiles) {
  const command = require(`./commands/${file}`);
  client.commands.set(command.name, command);
}

client.on('interactionCreate', async interaction => {
  if (!interaction.isCommand()) return;

  const command = client.commands.get(interaction.commandName);

  if (!command) return;

  try {
    await command.execute(interaction);
  } catch (error) {
    console.error(error);
    await interaction.reply({ content: 'There was an error while executing this command!', ephemeral: true });
  }
});

client.on('ready', () => {
  console.log('Bot is ready!');
});

client.login(token);
```

And here's an example code for a ban command:
```javascript
module.exports = {
  name: 'ban',
  description: 'Bans a member from the server.',
  options: [
    {
      name: 'member',
      description: 'The member to ban.',
      type: 'USER',
      required: true,
    },
    {
      name: 'reason',
      description: 'The reason for the ban.',
      type: 'STRING',
      required: false,
    },
  ],
  async execute(interaction) {
    const member = interaction.options.getMember('member');
    const reason = interaction.options.getString('reason') || 'No reason provided.';

    if (!member.bannable) {
      return interaction.reply({ content: 'I cannot ban this member.', ephemeral: true });
    }

    await member.ban({ reason });
    await interaction.reply({ content: `${member.user.tag} has been banned. Reason: ${reason}`, ephemeral: true });
  },
};
```