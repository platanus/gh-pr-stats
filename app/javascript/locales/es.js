export default {
  message: {
    settings: {
      button: 'Ir a dashboard',
      adminUsers: 'Administrar Usuarios',
      adminRepos: 'Administrar Repositorios',
      repoUpdate: 'Ultima vez actualizado el',
      sync: 'actualizar',
      loading: '...cargando',
      error: 'Ocurrió un error',
      disablePublic: 'Deshabilitar dashboard público',
      enablePublic: 'Habilitar dashboard público',
    },
    profile: {
      noTeams: 'Sin equipos',
      teamsDropdownTitle: 'Equipos',
      noOrganizations: 'Sin organizaciones',
      organizationsDropdownTitle: 'Organizaciones',
      recommendedReviewers: 'Deberías mandar tu próximo PR a...',
      notRecommendedReviewers: 'Evita mandar tu próximo PR a...',
      statistics: {
        obedientCount: 'Recomendaciones seguidas',
        indifferentCount: 'Recomendaciones ignoradas',
        rebelCount: 'Recomendaciones no seguidas',
      },
      timespanDropdownTitle: 'Desde hace',
      relationsTitle: 'Tu relación con el resto del equipo: ',
      badgeExplainer: {
        low: '¡También es parte de tu equipo! No lo ignores :(',
        midlow: '¡Todavía puedo ayudarte más!',
        good: 'Tu objetivo Froggo',
        midhigh: 'No te pases...',
        high: 'Parece que tienes una fijación...',
      },
    },
    admin: {
      noDefaultTeam: 'Sin equipo default',
      defaultTeamDropdownTitle: 'Equipo default',
    },
    froggoTeams: {
      organizationTitle: 'Organización: ',
      belongedTeams: 'Equipos a los que pertenezco: ',
      notBelongedTeams: 'Otros equipos de la organización: ',
      createButton: 'Crear Equipo',
      insertTeamName: 'Nombre del equipo: ',
      addMember: 'Agregar miembros: ',
      editName: 'Editar nombre',
      saveName: 'Guardar nombre',
      members: 'Miembros: ',
      deleteFromTeam: 'Quitar del equipo',
      saveChanges: 'Guardar cambios',
      editTeam: 'Editar equipo',
      deleteTeam: 'Eliminar equipo',
      successfullySavedChanges: 'Cambios guardados exitosamente',
      successfullyCreatedTeam: 'Equipo creado exitosamente',
    },
    prFeed: {
      noName: 'Desconocido',
      prName: 'Pull Request',
      prAuthor: 'Autor',
      prProject: 'Proyecto',
      prTime: 'Hora',
      prDate: 'Fecha',
      prDescription: 'Descripción',
      prCommits: 'Commits',
      prUnknown: '---',
      prReviewers: 'Reviewers',
      prGoToGithub: 'Ir a Github',
      prSee: 'Ver',
      prCreated: 'Creado por',
      prThe: 'el',
    },
    error: {
      unauthorized: 'No tiene autorización para realizar esta acción',
      existentName: 'Ese nombre ya existe para un equipo de la organización',
    },
    metrics: {
      noPullRequestInformation: 'No hay información de pull requests para obtener métricas',
      metricsTitle: 'Métricas de tiempo',
      creationToAssignmentTimeLabel: 'Tiempo entre creación y asignación de pull request',
      assignmentToResponseTimeLabel: 'Tiempo entre asignación y primera respuesta de pull request',
      responseToApprovalTimeLabel: 'Tiempo entre primera respuesta y aprobación de pull request',
      approvalToMergeTimeLabel: 'Tiempo entre aprobación y merge de pull request',
      bottomSummaryText: 'promedio de pull requests',
      creationToAssignmentSummaryText: 'creación y asignación',
      assignmentToResponseSummaryText: 'asignación y respuesta',
      responseToApprovalSummaryText: 'respuesta y aprobación',
      approvalToMergeSummaryText: 'aprobación y merge',
      chartYLabel: 'minutos',
    },
    time: {
      day: 'dia',
      hour: 'hora',
      minute: 'minuto',
    },
  },
};
