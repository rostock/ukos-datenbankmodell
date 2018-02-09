$(document).ready( function() {
    
  $('.codeliste').DataTable( {
    'language': {
      'lengthMenu': '_MENU_ Einträge anzeigen',
      'zeroRecords': 'keine Einträge gefunden',
      'info': 'Seite _PAGE_ von _PAGES_',
      'infoEmpty': 'keine Einträge gefunden',
      'infoFiltered': '(gefiltert aus insgesamt _MAX_ Einträgen)',
      'search': 'Filter:',
      'paginate': {
        'first': 'erste Seite',
        'last': 'letzte Seite',
        'next': 'vor',
        'previous': 'zurück'
      },
      'order': [[ 0, 'asc' ], [ 1, 'asc' ]]
    }
  } );
  
  $('.codeliste-strasse').DataTable( {
    'language': {
      'lengthMenu': '_MENU_ Einträge anzeigen',
      'zeroRecords': 'keine Einträge gefunden',
      'info': 'Seite _PAGE_ von _PAGES_',
      'infoEmpty': 'keine Einträge gefunden',
      'infoFiltered': '(gefiltert aus insgesamt _MAX_ Einträgen)',
      'search': 'Filter:',
      'paginate': {
        'first': 'erste Seite',
        'last': 'letzte Seite',
        'next': 'vor',
        'previous': 'zurück'
      },
      'order': [[ 1, 'asc' ], [ 3, 'asc' ]]
    }
  } );
  
} );