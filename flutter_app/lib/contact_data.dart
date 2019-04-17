class Contact {
  final String fullName;
  final String email;

  const Contact({this.fullName, this.email});
}

const kContacts = const <Contact>[
  const Contact(
      fullName: 'Bugs Bunny',
      email:'Salut'
  ),
  const Contact(
      fullName: 'San Goku',
      email:'Hey'
  )
];
